extends Node

const SAVE_PATH: String = "user://auth_session.json"

var jwt: String = ""
var refresh_token: String = ""

var user_id: int = -1
var username: String = ""
var email: String = ""
var device_fingerprint: String = ""
var is_guest: bool = false
var is_logged_in: bool = false
var jwt_exp_unix: int = 0  # seconds since epoch from JWT "exp"

func get_seconds_until_expiry() -> int:
	# If we never decoded exp or have no token, treat as expired.
	if jwt == "" or jwt_exp_unix <= 0:
		return -1

	# Get system time, convert to int AFTER assignment to avoid narrowing warnings.
	var now_unix = Time.get_unix_time_from_system()
	now_unix = int(now_unix)

	return jwt_exp_unix - now_unix


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

	var now_unix := Time.get_unix_time_from_system()
	return now_unix >= jwt_exp_unix - buffer_seconds


func get_auth_headers() -> Array:
	if jwt == "":
		return []
	return ["Authorization: Bearer %s" % jwt]


func apply_auth_response(data: Dictionary) -> void:
	jwt = data.get("jwt", "")
	refresh_token = data.get("refreshToken", "")

	_update_jwt_exp_from_token()  # <-- make sure this is here

	if data.has("user"):
		var user: Dictionary = data["user"]
		user_id = int(user.get("id", user_id))
		username = str(user.get("username", username))
		email = str(user.get("email", email))
		device_fingerprint = str(user.get("deviceFingerprint", device_fingerprint))
		is_guest = bool(user.get("isGuest", is_guest))

	is_logged_in = jwt != ""
	print("AuthManager updated. User:", username, "Guest:", is_guest)





func to_dict() -> Dictionary:
	return {
		"jwt": jwt,
		"refreshToken": refresh_token,
		"user_id": user_id,
		"username": username,
		"email": email,
		"deviceFingerprint": device_fingerprint,
		"isGuest": is_guest,
		"isLoggedIn": is_logged_in
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

	# Recompute exp from loaded JWT
	_update_jwt_exp_from_token()




func save_session() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("AuthManager: failed to open save file: %s" % FileAccess.get_open_error())
		return

	var data := to_dict()
	file.store_string(JSON.stringify(data))
	file.close()
	print("AuthManager: session saved to disk.")


func load_session() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		print("AuthManager: no saved session on disk.")
		return false

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("AuthManager: failed to open save file for read: %s" % FileAccess.get_open_error())
		return false

	var text := file.get_as_text()
	file.close()

	var data = JSON.parse_string(text)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("AuthManager: saved session is not a dictionary.")
		return false

	from_dict(data)

	print("AuthManager: loaded session from disk. User:", username, "Guest:", is_guest)
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

	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)

	print("AuthManager: session cleared.")
