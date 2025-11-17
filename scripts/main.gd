extends Control

@onready var http: HTTPRequest = $AuthHTTPRequest
@onready var refresh_http: HTTPRequest = $RefreshHTTPRequest
@onready var refresh_timer: Timer = $RefreshTimer


func _ready() -> void:
	if AuthManager.is_logged_in:
		print("Using persisted session.")
		schedule_refresh_timer(60)  # 60s buffer before expiry
	else:
		_guest_login()


func schedule_refresh_timer(buffer_seconds: int = 60) -> void:
	# If we’re not logged in, no need to refresh tokens.
	if not AuthManager.is_logged_in:
		if not refresh_timer.is_stopped():
			refresh_timer.stop()
		return

	var secs_left: int = AuthManager.get_seconds_until_expiry()
	print("JWT seconds until expiry:", secs_left)

	# If token is already expired or will expire within the buffer → refresh now.
	if secs_left <= buffer_seconds:
		print("JWT expires soon or already expired → refreshing immediately.")
		refresh_jwt()
		return

	var wait_time: int = secs_left - buffer_seconds

	# Safety guard: don't schedule extremely tiny waits.
	if wait_time < 5:
		wait_time = 5

	refresh_timer.wait_time = float(wait_time)
	refresh_timer.start()
	print("RefreshTimer scheduled to run in", wait_time, "seconds.")


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

	print("Sending guest login to:", url)
	print("Body:", json_body)

	var err := http.request(url, headers, HTTPClient.METHOD_POST, json_body)
	if err != OK:
		push_error("Guest login request failed to send: %s" % err)


func _on_auth_http_request_request_completed(
		_result: int,
		response_code: int,
		_headers: PackedStringArray,
		body: PackedByteArray
	) -> void:
	var text: String = body.get_string_from_utf8()
	print("Guest response code:", response_code)
	print("Guest response body:", text)

	if response_code != 201:
		push_error("Guest login failed: %d %s" % [response_code, text])
		return

	var data = JSON.parse_string(text)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Guest login: response not a JSON object")
		return

	AuthManager.apply_auth_response(data)
	AuthManager.save_session()

	print("Guest login OK! User:", AuthManager.username)
	print("JWT:", AuthManager.jwt)

	schedule_refresh_timer(60)


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

	print("Sending refresh request to:", url)
	print("Refresh body:", json_body)

	var err := refresh_http.request(url, headers, HTTPClient.METHOD_POST, json_body)
	if err != OK:
		push_error("Refresh request failed to send: %s" % err)


func _on_refresh_http_request_request_completed(
		_result: int,
		response_code: int,
		_headers: PackedStringArray,
		body: PackedByteArray
	) -> void:
	var text: String = body.get_string_from_utf8()
	print("Refresh response code:", response_code)
	print("Refresh response body:", text)

	if response_code != 200:
		if response_code == 401:
			# Refresh token invalid or expired – handle gracefully.
			print("Refresh token invalid → clearing session and doing new guest login.")
			AuthManager.clear_session()
			_guest_login()
		else:
			# Other errors are still treated as real errors.
			push_error("Token refresh failed: %d %s" % [response_code, text])
		return

	var data = JSON.parse_string(text)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Refresh: response not a JSON object")
		return

	AuthManager.apply_auth_response(data)
	AuthManager.save_session()

	print("Refresh OK! New JWT:", AuthManager.jwt)

	# Re-schedule next refresh based on the new token's exp.
	schedule_refresh_timer(60)




func _on_refresh_timer_timeout() -> void:
	print("RefreshTimer timeout → re-checking JWT.")
	schedule_refresh_timer()  # will either refresh now or reschedule
