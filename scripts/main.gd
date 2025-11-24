extends Control

# =========================
#  DEBUG & ZONE SPLITS
# =========================
@export_category("Debug & Zones")

@export_group("Overlay")
@export var debug_show_zones: bool = true

@export_group("Zones for 1x zoom")
@export_range(0.0, 1.0) var z1_left: float = 0.33
@export_range(0.0, 1.0) var z1_right: float = 0.66

@export_group("Zones for 2x zoom")
@export_range(0.0, 1.0) var z2_left: float = 0.33
@export_range(0.0, 1.0) var z2_right: float = 0.66

@export_group("Zones for 2.5x zoom")
@export_range(0.0, 1.0) var z25_left: float = 0.33
@export_range(0.0, 1.0) var z25_right: float = 0.66

@export_group("Zones for 3x zoom")
@export_range(0.0, 1.0) var z3_left: float = 0.33
@export_range(0.0, 1.0) var z3_right: float = 0.66


# =========================
#  CAMERA: ZOOM & MARGINS
# =========================
@export_category("Camera")

@export_group("Zoom Levels")
@export var zoom_1x: float = 1.0
@export var zoom_2x: float = 2.0
@export var zoom_25x: float = 2.5
@export var zoom_3x: float = 3.0

@export_group("Margins for 1x zoom")
@export var m1_left: float = 24.0
@export var m1_right: float = 24.0
@export var m1_top: float = 140.0
@export var m1_bottom: float = 80.0

@export_group("Margins for 2x zoom")
@export var m2_left: float = 24.0
@export var m2_right: float = 24.0
@export var m2_top: float = 120.0
@export var m2_bottom: float = 80.0

@export_group("Margins for 2.5x zoom")
@export var m25_left: float = 24.0
@export var m25_right: float = 24.0
@export var m25_top: float = 100.0
@export var m25_bottom: float = 80.0

@export_group("Margins for 3x zoom")
@export var m3_left: float = 24.0
@export var m3_right: float = 24.0
@export var m3_top: float = 80.0
@export var m3_bottom: float = 80.0


# =========================
#  PLAYER SNAP OFFSETS
# =========================
@export_category("Player")

@export_group("Snap offset per zoom (pixels above bottom clamp)")
@export var s1_bottom: float = 20.0
@export var s2_bottom: float = 20.0
@export var s25_bottom: float = 20.0
@export var s3_bottom: float = 20.0


# =========================
#  NON-EXPORTED NODES & STATE
# =========================
@onready var http: HTTPRequest = $AuthHTTPRequest
@onready var refresh_http: HTTPRequest = $RefreshHTTPRequest
@onready var refresh_timer: Timer = $RefreshTimer

# Refresh safety constants
const MIN_FORCE_REFRESH_THRESHOLD := 5      # seconds: if <= this, refresh now
const MIN_REFRESH_INTERVAL := 10           # seconds: never schedule tighter than this
const DESIRED_REFRESH_BUFFER := 60         # "nice" lead time for long-lived tokens

var last_refresh_time_unix: int = 0
var refresh_in_progress: bool = false

@onready var cam: Camera2D = $Camera2D
@onready var player := $Player

var zoom_levels: Array[float] = []
var zoom_index: int = 0

# Zoom/Zone status labels
@onready var zoom_status: Label = $UI/DebugPanel/ZoomStatus
@onready var zone_status: Label = $UI/DebugPanel/ZoneStatus
@onready var debug_panel: Control = $UI/DebugPanel

#Console Button & labels
@onready var debug_log_view: RichTextLabel = $UI/DebugPanel/DebugLogView
@onready var debug_log_toggle: TextureButton = $UI/DebugPanel/LogToggleButton
@onready var debug_log_backdrop: ColorRect = $UI/DebugPanel/DebugLogBackdrop


func _ready() -> void:
	# --- Zoom setup ---
	zoom_levels = [
		zoom_1x,
		zoom_2x,
		zoom_25x,
		zoom_3x,
	]

	# Start at 3x (base game zoom)
	zoom_index = 3
	set_zoom_immediate(zoom_levels[zoom_index])

	# Wait one frame so the viewport & camera are correct
	await get_tree().process_frame

	# Apply margins & zones for this zoom
	apply_zone_splits_for_current_zoom()
	apply_margins_for_current_zoom()

	# Place the player correctly for this zoom level
	player.snap_to_bottom_center(get_snap_offset_for_current_zoom())

	# Initialize zoom label once at startup
	if zoom_status:
		var z := zoom_levels[zoom_index]
		zoom_status.text = "Zoom: " + str(z) + "x"

	# Ensure zone state is up to date and log starting zone
	player._update_zone()
	var start_zone_text := "MIDDLE"
	match player.current_zone:
		player.Zone.LEFT:
			start_zone_text = "LEFT"
		player.Zone.MIDDLE:
			start_zone_text = "MIDDLE"
		player.Zone.RIGHT:
			start_zone_text = "RIGHT"

	GlobalLogger.log("Player start zone: %s" % start_zone_text)

	if zone_status:
		zone_status.text = "Zone: " + start_zone_text

	# Connect zone change signal
	player.zone_changed.connect(_on_player_zone_changed)

	# --- Existing auth logic ---
	if AuthManager.is_logged_in:
		GlobalLogger.log("Using persisted session.")
		schedule_refresh_timer()
	else:
		GlobalLogger.log("No session → performing guest login.")
		_guest_login()

	# --- Debug overlay & panel initial visibility ---
	# ONE flag from the Inspector (debug_show_zones)
	# controls BOTH the overlay and the DebugPanel.
	if debug_panel:
		debug_panel.visible = debug_show_zones

	# Log view + backdrop start hidden; Log button will show/hide them
	if debug_log_view:
		debug_log_view.visible = false
	if debug_log_backdrop:
		debug_log_backdrop.visible = false

	# --- Connect log stream from GlobalLogger to the UI ---
	if not is_instance_valid(debug_log_view):
		GlobalLogger.log("Main._ready: ERROR – debug_log_view is null, cannot connect log stream.")
	else:
		GlobalLogger.log("Main._ready: connecting GlobalLogger.log_appended → _on_log_appended")
		GlobalLogger.log_appended.connect(_on_log_appended)
		debug_log_view.text = GlobalLogger.get_all_text()



func _process(_delta: float) -> void:
	# Always keep margins & zone splits in sync with current zoom
	apply_margins_for_current_zoom()
	apply_zone_splits_for_current_zoom()

	# Always request redraw – _draw() will decide whether to show zones or not
	queue_redraw()


# =========================
#  TOKEN REFRESH SCHEDULING
# =========================
func schedule_refresh_timer() -> void:
	if not AuthManager.is_logged_in:
		if not refresh_timer.is_stopped():
			refresh_timer.stop()
		return

	var secs_left: int = AuthManager.get_seconds_until_expiry()
	GlobalLogger.log("JWT seconds until expiry: %s" % secs_left)

	# If we think it's basically expired, refresh once now.
	if secs_left <= MIN_FORCE_REFRESH_THRESHOLD:
		GlobalLogger.log("JWT expired or about to expire → refreshing now.")
		_safe_refresh_jwt()
		return

	# How far before expiry we want to refresh: start with half the remaining lifetime.
	var ahead: int = int(secs_left / 2.0)

	# Never cut it closer than (MIN_FORCE_REFRESH_THRESHOLD + 5)
	if ahead < MIN_FORCE_REFRESH_THRESHOLD + 5:
		ahead = MIN_FORCE_REFRESH_THRESHOLD + 5

	# Don't try to be more than DESIRED_REFRESH_BUFFER early
	if ahead > DESIRED_REFRESH_BUFFER:
		ahead = DESIRED_REFRESH_BUFFER

	# When should the timer fire?
	var wait_time: int = secs_left - ahead

	# Never schedule super-tight loops
	if wait_time < MIN_REFRESH_INTERVAL:
		wait_time = MIN_REFRESH_INTERVAL

	# Upper safety: never schedule after (expiry - MIN_FORCE_REFRESH_THRESHOLD)
	var max_safe_wait: int = secs_left - MIN_FORCE_REFRESH_THRESHOLD
	if wait_time > max_safe_wait:
		wait_time = max_safe_wait

	# If math gets weird, refresh now
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
#  AUTH / HTTP
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
	# Decode server reply
	var text := body.get_string_from_utf8()

	# --- DIAGNOSTIC LOGGING ---
	GlobalLogger.log("Auth HTTP result (raw): %s" % _result)
	GlobalLogger.log("Auth HTTP result (name): %s" % http_result_to_string(_result))
	GlobalLogger.log("Guest response code: %s" % response_code)
	GlobalLogger.log("Guest response body: %s" % text)

	# --------------------------

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


	schedule_refresh_timer()  # no arg


# Helper function to interpret HTTPRequest result codes
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
		_:
			return "Unknown result: %s" % result


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
	# Prevent overlapping refreshes
	if refresh_in_progress:
		GlobalLogger.log("Refresh already in progress → skipping extra call.")
		return

	var now := int(Time.get_unix_time_from_system())
	if last_refresh_time_unix > 0 and now - last_refresh_time_unix < 5:
		GlobalLogger.log(
	"Last refresh was %s s ago → delaying to avoid spam."
	% (now - last_refresh_time_unix)
)
		# Back off a bit instead of hammering
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
	# Always clear the in-progress flag when the HTTP finishes.
	refresh_in_progress = false

	var text: String = body.get_string_from_utf8()
	GlobalLogger.log("Refresh response code: %s" % response_code)
	GlobalLogger.log("Refresh response body: %s" % text)


	if response_code != 200:
		if response_code == 401:
			GlobalLogger.log("Refresh token invalid → clearing session and doing new guest login.")

			AuthManager.clear_session()
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
	schedule_refresh_timer()  # no arg


func _on_refresh_timer_timeout() -> void:
	GlobalLogger.log("RefreshTimer timeout → re-checking JWT.")
	schedule_refresh_timer()  # will either refresh now or reschedule


# =========================
#  CAMERA / ZOOM HELPERS
# =========================
func set_zoom_immediate(amount: float) -> void:
	cam.zoom = Vector2(amount, amount)


func tween_zoom(amount: float, duration: float = 0.7) -> void:
	var tween := create_tween()
	tween.tween_property(
		cam,
		"zoom",
		Vector2(amount, amount),
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func get_snap_offset_for_current_zoom() -> float:
	match zoom_index:
		0:
			return s1_bottom
		1:
			return s2_bottom
		2:
			return s25_bottom
		3:
			return s3_bottom
		_:
			return s1_bottom


func apply_margins_for_current_zoom() -> void:
	match zoom_index:
		0:
			player.set_clamp_margins(m1_left, m1_right, m1_top, m1_bottom)
		1:
			player.set_clamp_margins(m2_left, m2_right, m2_top, m2_bottom)
		2:
			player.set_clamp_margins(m25_left, m25_right, m25_top, m25_bottom)
		3:
			player.set_clamp_margins(m3_left, m3_right, m3_top, m3_bottom)
		_:
			player.set_clamp_margins(m1_left, m1_right, m1_top, m1_bottom)


# =========================
#  ZONE SPLITS & OVERLAY
# =========================
func apply_zone_splits_for_current_zoom() -> void:
	match zoom_index:
		0:
			player.set_zone_splits(z1_left, z1_right)   # 1x
		1:
			player.set_zone_splits(z2_left, z2_right)   # 2x
		2:
			player.set_zone_splits(z25_left, z25_right) # 2.5x
		3:
			player.set_zone_splits(z3_left, z3_right)   # 3x
		_:
			player.set_zone_splits(z1_left, z1_right)


func _draw() -> void:
	if not debug_show_zones:
		return
	if player == null or cam == null:
		return

	# 1) Viewport / camera info
	var rect: Rect2 = get_viewport().get_visible_rect()
	var screen_size: Vector2 = rect.size

	var z: Vector2 = cam.zoom
	var half_w: float = (screen_size.x * 0.5) / z.x
	var half_h: float = (screen_size.y * 0.5) / z.y

	var cam_pos: Vector2 = cam.global_position
	var world_left: float = cam_pos.x - half_w
	var world_right: float = cam_pos.x + half_w
	var world_top: float = cam_pos.y - half_h
	var world_bottom: float = cam_pos.y + half_h
	var height: float = world_bottom - world_top

	# 2) World-space zone boundaries (fractions along visible width)
	var split1_x: float = lerp(world_left, world_right, player.zone_split_left)
	var split2_x: float = lerp(world_left, world_right, player.zone_split_right)

	# 3) Colors (still neon and semi-opaque)
	var col_left  := Color(0.0, 1.0, 1.0, 0.45)  # neon cyan
	var col_mid   := Color(0.0, 1.0, 0.0, 0.45)  # neon green
	var col_right := Color(1.0, 0.0, 1.0, 0.45)  # neon magenta

	# Left zone
	draw_rect(
		Rect2(
			Vector2(world_left, world_top),
			Vector2(split1_x - world_left, height)
		),
		col_left,
		true
	)

	# Middle zone
	draw_rect(
		Rect2(
			Vector2(split1_x, world_top),
			Vector2(split2_x - split1_x, height)
		),
		col_mid,
		true
	)

	# Right zone
	draw_rect(
		Rect2(
			Vector2(split2_x, world_top),
			Vector2(world_right - split2_x, height)
		),
		col_right,
		true
	)

	# 4) White separator lines on the boundaries
	var line_color := Color(1, 1, 1, 0.9)
	draw_line(Vector2(split1_x, world_top), Vector2(split1_x, world_bottom), line_color, 3.0)
	draw_line(Vector2(split2_x, world_top), Vector2(split2_x, world_bottom), line_color, 3.0)

	# 5) Zone debug text labels
	var font := get_theme_default_font()
	var font_size: int = get_theme_default_font_size()
	if font:
		var label_y: float = world_top + 24.0
		var text_color := Color(1, 1, 1, 0.95)

		# LEFT zone label
		draw_string(
			font,
			Vector2(world_left + 20.0, label_y),
			"LEFT",
			HORIZONTAL_ALIGNMENT_LEFT,
			-1.0,
			font_size,
			text_color
		)

		# MIDDLE zone label
		draw_string(
			font,
			Vector2(split1_x + 20.0, label_y),
			"MIDDLE",
			HORIZONTAL_ALIGNMENT_LEFT,
			-1.0,
			font_size,
			text_color
		)

		# RIGHT zone label
		draw_string(
			font,
			Vector2(split2_x + 20.0, label_y),
			"RIGHT",
			HORIZONTAL_ALIGNMENT_LEFT,
			-1.0,
			font_size,
			text_color
		)


func _on_player_zone_changed(_old_zone: int, new_zone: int) -> void:
	var zone_name := "MIDDLE"
	match new_zone:
		player.Zone.LEFT:
			zone_name = "LEFT"
		player.Zone.MIDDLE:
			zone_name = "MIDDLE"
		player.Zone.RIGHT:
			zone_name = "RIGHT"

	# Console log (keeps your existing debug)
	GlobalLogger.log("Player moved into %s zone" % zone_name)

	# On-screen text
	if zone_status:
		zone_status.text = "Zone: " + zone_name


# =========================
#  BUTTON HELPERS
# =========================
func cycle_zoom() -> void:
	zoom_index = (zoom_index + 1) % zoom_levels.size()
	var new_zoom: float = zoom_levels[zoom_index]

	# Apply zoom
	tween_zoom(new_zoom)

	# Keep all the systems in sync with this zoom
	apply_margins_for_current_zoom()
	apply_zone_splits_for_current_zoom()

	# Reposition player for this zoom
	player.snap_to_bottom_center(get_snap_offset_for_current_zoom())

	# Update the UI label if it exists
	if zoom_status:
		zoom_status.text = "Zoom: " + str(new_zoom) + "x"
	GlobalLogger.log("Zoom switched to: %s" % str(new_zoom))

func _update_zoom_status() -> void:
	if zoom_status:
		var current_zoom := zoom_levels[zoom_index]
		zoom_status.text = "Zoom: " + str(current_zoom) + "x"


func toggle_debug_zones() -> void:
	debug_show_zones = !debug_show_zones
	queue_redraw()

	var state_text := "OFF"
	if debug_show_zones:
		state_text = "ON"

	GlobalLogger.log("Debug zones: %s" % state_text)

	# Use SAME flag to show/hide the debug panel
	if debug_panel:
		debug_panel.visible = debug_show_zones

		
func _on_log_appended(_line: String) -> void:
	# DEBUG TEST — this prints safely without causing recursion
	print("DEBUG: _on_log_appended fired: ", _line)

	if not is_instance_valid(debug_log_view):
		return

	# Always mirror the full collected log
	debug_log_view.text = GlobalLogger.get_all_text()

	# Auto-scroll to bottom
	var line_count := debug_log_view.get_line_count()
	if line_count > 0:
		debug_log_view.scroll_to_line(line_count - 1)


func _on_LogToggleButton_toggled(pressed: bool) -> void:
	GlobalLogger.log("LogToggleButton toggled: %s" % pressed)

	if not is_instance_valid(debug_log_view):
		return

	# Show/hide the log text
	debug_log_view.visible = pressed

	# Show/hide the dark background with the console
	if is_instance_valid(debug_log_backdrop):
		debug_log_backdrop.visible = pressed

	# Optional: when turning it ON, force a refresh and scroll
	if pressed:
		debug_log_view.text = GlobalLogger.get_all_text()
		var line_count := debug_log_view.get_line_count()
		if line_count > 0:
			debug_log_view.scroll_to_line(line_count - 1)
