extends Node
class_name AuthService

@onready var http: HTTPRequest = $"../AuthHTTPRequest"
@onready var refresh_http: HTTPRequest = $"../RefreshHTTPRequest"
@onready var refresh_timer: Timer = $"../RefreshTimer"

const MIN_FORCE_REFRESH_THRESHOLD := 5
const MIN_REFRESH_INTERVAL := 10
const DESIRED_REFRESH_BUFFER := 60

var last_refresh_time_unix: int = 0
var refresh_in_progress: bool = false

signal session_ready
signal session_cleared

func _ready() -> void:
	# Wire HTTP + timer signals to this service
	if http and not http.request_completed.is_connected(_on_auth_http_request_request_completed):
		http.request_completed.connect(_on_auth_http_request_request_completed)

	if refresh_http and not refresh_http.request_completed.is_connected(_on_refresh_http_request_request_completed):
		refresh_http.request_completed.connect(_on_refresh_http_request_request_completed)

	if refresh_timer and not refresh_timer.timeout.is_connected(_on_refresh_timer_timeout):
		refresh_timer.timeout.connect(_on_refresh_timer_timeout)

	# Same logic Main used to have in _ready()
	if AuthManager.is_logged_in:
		GlobalLogger.log("Using persisted session.")
		schedule_refresh_timer()
	else:
		GlobalLogger.log("No session → performing guest login.")
		_guest_login()

# =========================
#  PUBLIC API (for future)
# =========================

func guest_login() -> void:
	_guest_login()

func force_refresh_now() -> void:
	_safe_refresh_jwt()

func schedule_refresh_timer() -> void:
	if not AuthManager.is_logged_in:
		if refresh_timer and not refresh_timer.is_stopped():
			refresh_timer.stop()
		return

	var secs_left: int = AuthManager.get_seconds_until_expiry()
	GlobalLogger.log("JWT seconds until expiry: %s" % secs_left)

	if secs_left <= MIN_FORCE_REFRESH_THRESHOLD:
		GlobalLogger.log("JWT expired or about to expire → refreshing now.")
		_safe_refresh_jwt()
		return

	var ahead: int = int(secs_left / 2.0)
	if ahead < MIN_FORCE_REFRESH_THRESHOLD + 5:
		ahead = MIN_FORCE_REFRESH_THRESHOLD + 5
	if ahead > DESIRED_REFRESH_BUFFER:
		ahead = DESIRED_REFRESH_BUFFER

	var wait_time: int = secs_left - ahead
	if wait_time < MIN_REFRESH_INTERVAL:
		wait_time = MIN_REFRESH_INTERVAL

	var max_safe_wait: int = secs_left - MIN_FORCE_REFRESH_THRESHOLD
	if wait_time > max_safe_wait:
		wait_time = max_safe_wait

	if wait_time <= 0:
		GlobalLogger.log("Computed wait_time <= 0 → refreshing immediately to avoid gap.")
		_safe_refresh_jwt()
		return

	refresh_timer.wait_time = float(wait_time)
	refresh_timer.start()

	GlobalLogger.log(
		"RefreshTimer scheduled: wait=%s s (secs_left=%s, ahead=%s)"
		% [wait_time, secs_left, ahead]
	)

# =========================
#  INTERNAL: GUEST LOGIN
# =========================

func _guest_login() -> void:
	var url: String = Global.api_base_url + "/v1/auth/guest"

	var fingerprint: String = OS.get_unique_id().strip_edges().replace("{", "").replace("}", "")
	AuthManager.device_fingerprint = fingerprint

	var body := {
		"deviceFingerprint": fingerprint,
		"client": "game"
	}

	var headers := ["Content-Type: application/json"]
	var json_body: String = JSON.stringify(body)

	GlobalLogger.log("Sending guest login to: %s" % url)
	GlobalLogger.log("Guest login body: %s" % json_body)

	var err := http.request(url, headers, HTTPClient.METHOD_POST, json_body)
	if err != OK:
		push_error("Guest login request failed to send: %s" % err)

func _on_auth_http_request_request_completed(
	_result: int,
	response_code: int,
	_headers: PackedStringArray,
	body: PackedByteArray
) -> void:
	var text := body.get_string_from_utf8()

	GlobalLogger.log("Auth HTTP result (raw): %s" % _result)
	GlobalLogger.log("Auth HTTP result (name): %s" % http_result_to_string(_result))
	GlobalLogger.log("Guest response code: %s" % response_code)
	GlobalLogger.log("Guest response body: %s" % text)

	if response_code != 201:
		push_error("Guest login failed: %d %s" % [response_code, text])
		return

	var data = JSON.parse_string(text)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Guest login: response not a JSON object")
		return

	AuthManager.apply_auth_response(data)
	AuthManager.save_session()

	GlobalLogger.log("Guest login OK! User: %s" % AuthManager.username)
	GlobalLogger.log("JWT: %s" % AuthManager.jwt)

	schedule_refresh_timer()
	session_ready.emit()

func http_result_to_string(result: int) -> String:
	match result:
		HTTPRequest.RESULT_SUCCESS: return "RESULT_SUCCESS"
		HTTPRequest.RESULT_CHUNKED_BODY_SIZE_MISMATCH: return "RESULT_CHUNKED_BODY_SIZE_MISMATCH"
		HTTPRequest.RESULT_CANT_CONNECT: return "RESULT_CANT_CONNECT"
		HTTPRequest.RESULT_CONNECTION_ERROR: return "RESULT_CONNECTION_ERROR"
		HTTPRequest.RESULT_TLS_HANDSHAKE_ERROR: return "RESULT_TLS_HANDSHAKE_ERROR"
		HTTPRequest.RESULT_NO_RESPONSE: return "RESULT_NO_RESPONSE"
		HTTPRequest.RESULT_BODY_SIZE_LIMIT_EXCEEDED: return "RESULT_BODY_SIZE_LIMIT_EXCEEDED"
		HTTPRequest.RESULT_BODY_DECOMPRESS_FAILED: return "RESULT_BODY_DECOMPRESS_FAILED"
		_: return "Unknown result: %s" % result

# =========================
#  REFRESH FLOW
# =========================

func refresh_jwt() -> void:
	if AuthManager.refresh_token == "":
		push_error("No refresh token stored; cannot refresh.")
		return

	var url: String = Global.api_base_url + "/v1/auth/refresh"

	var body := {
		"refreshToken": AuthManager.refresh_token,
		"client": "game"
	}

	var headers := ["Content-Type: application/json"]
	var json_body: String = JSON.stringify(body)

	GlobalLogger.log("Sending refresh request to: %s" % url)
	GlobalLogger.log("Refresh body: %s" % json_body)

	var err := refresh_http.request(url, headers, HTTPClient.METHOD_POST, json_body)
	if err != OK:
		push_error("Refresh request failed to send: %s" % err)

func _safe_refresh_jwt() -> void:
	if refresh_in_progress:
		GlobalLogger.log("Refresh already in progress → skipping extra call.")
		return

	var now := int(Time.get_unix_time_from_system())
	if last_refresh_time_unix > 0 and now - last_refresh_time_unix < 5:
		GlobalLogger.log(
			"Last refresh was %s s ago → delaying to avoid spam."
			% (now - last_refresh_time_unix)
		)
		refresh_timer.wait_time = 5.0
		refresh_timer.start()
		return

	refresh_in_progress = true
	last_refresh_time_unix = now
	refresh_jwt()

func _on_refresh_http_request_request_completed(
	_result: int,
	response_code: int,
	_headers: PackedStringArray,
	body: PackedByteArray
) -> void:
	refresh_in_progress = false

	var text: String = body.get_string_from_utf8()
	GlobalLogger.log("Refresh response code: %s" % response_code)
	GlobalLogger.log("Refresh response body: %s" % text)

	if response_code != 200:
		if response_code == 401:
			GlobalLogger.log("Refresh token invalid → clearing session and doing new guest login.")
			AuthManager.clear_session()
			session_cleared.emit()
			_guest_login()
		else:
			push_error("Token refresh failed: %d %s" % [response_code, text])
		return

	var data = JSON.parse_string(text)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Refresh: response not a JSON object")
		return

	AuthManager.apply_auth_response(data)
	AuthManager.save_session()

	GlobalLogger.log("Refresh OK! New JWT: %s" % AuthManager.jwt)
	schedule_refresh_timer()
	session_ready.emit()

func _on_refresh_timer_timeout() -> void:
	GlobalLogger.log("RefreshTimer timeout → re-checking JWT.")
	schedule_refresh_timer()
