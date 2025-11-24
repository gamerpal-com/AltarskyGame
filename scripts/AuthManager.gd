extends Node

const SAVE_PATH: String = "user://auth_session.json"

# How far the device clock is allowed to drift (in seconds) before we stop
# trusting the stored server offset and fall back to raw device time.
const MAX_TRUSTED_DRIFT: int = 300  # 5 minutes – tweak if you like

var jwt: String = ""
var refresh_token: String = ""

var user_id: int = -1
var username: String = ""
var email: String = ""
var device_fingerprint: String = ""
var is_guest: bool = false
var is_logged_in: bool = false
var jwt_exp_unix: int = 0  # seconds since epoch from JWT "exp"

# --- New time-sync fields ---
var server_time_unix: int = 0          # last serverTime we saw
var server_client_offset: int = 0      # server_time_unix - device_time_at_sync
var last_server_sync_unix: int = 0     # device time when we last applied serverTime


# Returns how many seconds are left on the JWT, using server-time offset
# when available, and with clock-jump protection.
func get_seconds_until_expiry() -> int:
	# If we never decoded exp or have no token, treat as expired.
	if jwt == "" or jwt_exp_unix <= 0:
		return -1

	var now_unix := _get_now_unix()
	return jwt_exp_unix - now_unix


# Internal helper: current "trusted" time.
# Uses serverTime offset, but will reset it if the device clock jumps too far.
func _get_now_unix() -> int:
	var device_now := int(Time.get_unix_time_from_system())

	# No offset stored? Just use the device clock.
	if server_client_offset == 0 or last_server_sync_unix == 0:
		return device_now

	# How long (in seconds) since we last synced with server?
	var delta := device_now - last_server_sync_unix

	# If device clock appears to have jumped a lot (forward or backward),
	# stop trusting the offset and fall back to raw device time.
	if abs(delta) > MAX_TRUSTED_DRIFT:
		GlobalLogger.log(
			"AuthManager: device clock changed by %s s since last server sync → resetting server offset." % delta
		)
		server_client_offset = 0
		last_server_sync_unix = 0
		return device_now

	# Otherwise adjust by the known offset: serverTime = deviceTime + offset
	return device_now + server_client_offset


func _update_jwt_exp_from_token() -> void:
	jwt_exp_unix = 0

	if jwt == "":
		return

	var parts: PackedStringArray = jwt.split(".")
	if parts.size() < 2:
		return

	var payload_b64 := parts[1]

	# JWT uses base64url, so fix it for normal base64
	payload_b64 = payload_b64.replace("-", "+").replace("_", "/")

	# Add padding if needed
	while payload_b64.length() % 4 != 0:
		payload_b64 += "="

	var bytes: PackedByteArray = Marshalls.base64_to_raw(payload_b64)
	if bytes.is_empty():
		return

	var json_str := bytes.get_string_from_utf8()
	var payload = JSON.parse_string(json_str)
	if typeof(payload) == TYPE_DICTIONARY and payload.has("exp"):
		jwt_exp_unix = int(payload["exp"])


func is_jwt_near_expiry(buffer_seconds: int = 60) -> bool:
	# No token at all? Treat as expired.
	if jwt == "" or jwt_exp_unix <= 0:
		return true

	return get_seconds_until_expiry() <= buffer_seconds


func get_auth_headers() -> Array:
	if jwt == "":
		return []
	return ["Authorization: Bearer %s" % jwt]


# NEW: apply serverTime from backend
func _apply_server_time(server_time: int) -> void:
	var device_now := int(Time.get_unix_time_from_system())
	server_time_unix = server_time
	server_client_offset = server_time - device_now
	last_server_sync_unix = device_now

	GlobalLogger.log(
		"AuthManager: synced serverTime=%s deviceNow=%s offset=%s"
		% [server_time_unix, device_now, server_client_offset]
	)


func apply_auth_response(data: Dictionary) -> void:
	jwt = data.get("jwt", "")
	refresh_token = data.get("refreshToken", "")

	_update_jwt_exp_from_token()  # <-- decode "exp" from new JWT

	# If backend sends serverTime at the top level, use it
	if data.has("serverTime"):
		var st = int(data["serverTime"])
		_apply_server_time(st)

	if data.has("user"):
		var user: Dictionary = data["user"]
		user_id = int(user.get("id", user_id))
		username = str(user.get("username", username))
		email = str(user.get("email", email))
		device_fingerprint = str(user.get("deviceFingerprint", device_fingerprint))
		is_guest = bool(user.get("isGuest", is_guest))

	is_logged_in = jwt != ""
	GlobalLogger.log(
		"AuthManager updated. User: %s Guest: %s"
		% [username, str(is_guest)]
	)


func to_dict() -> Dictionary:
	return {
		"jwt": jwt,
		"refreshToken": refresh_token,
		"user_id": user_id,
		"username": username,
		"email": email,
		"deviceFingerprint": device_fingerprint,
		"isGuest": is_guest,
		"isLoggedIn": is_logged_in,
		# time-sync fields
		"serverTimeUnix": server_time_unix,
		"serverClientOffset": server_client_offset,
		"lastServerSyncUnix": last_server_sync_unix,
	}


func from_dict(data: Dictionary) -> void:
	jwt = str(data.get("jwt", ""))
	refresh_token = str(data.get("refreshToken", ""))

	user_id = int(data.get("user_id", -1))
	username = str(data.get("username", ""))
	email = str(data.get("email", ""))
	device_fingerprint = str(data.get("deviceFingerprint", ""))
	is_guest = bool(data.get("isGuest", false))
	is_logged_in = bool(data.get("isLoggedIn", false))

	# Restore time-sync fields if present (safe defaults otherwise)
	server_time_unix = int(data.get("serverTimeUnix", 0))
	server_client_offset = int(data.get("serverClientOffset", 0))
	last_server_sync_unix = int(data.get("lastServerSyncUnix", 0))

	# Recompute exp from loaded JWT
	_update_jwt_exp_from_token()


func save_session() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		var msg := "AuthManager: failed to open save file: %s" % FileAccess.get_open_error()
		push_error(msg)
		GlobalLogger.log(msg)
		return

	var data := to_dict()
	file.store_string(JSON.stringify(data))
	file.close()
	GlobalLogger.log("AuthManager: session saved to disk.")


func load_session() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		GlobalLogger.log("AuthManager: no saved session on disk.")
		return false

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		var msg := "AuthManager: failed to open save file for read: %s" % FileAccess.get_open_error()
		push_error(msg)
		GlobalLogger.log(msg)
		return false

	var text := file.get_as_text()
	file.close()

	var data = JSON.parse_string(text)
	if typeof(data) != TYPE_DICTIONARY:
		var msg_bad := "AuthManager: saved session is not a dictionary."
		push_error(msg_bad)
		GlobalLogger.log(msg_bad)
		return false

	from_dict(data)

	GlobalLogger.log(
		"AuthManager: loaded session from disk. User: %s Guest: %s"
		% [username, str(is_guest)]
	)
	return is_logged_in and jwt != ""


func clear_session() -> void:
	jwt = ""
	refresh_token = ""
	user_id = -1
	username = ""
	email = ""
	device_fingerprint = ""
	is_guest = false
	is_logged_in = false
	jwt_exp_unix = 0

	# Reset server-time tracking too
	server_time_unix = 0
	server_client_offset = 0
	last_server_sync_unix = 0

	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)

	GlobalLogger.log("AuthManager: session cleared.")
