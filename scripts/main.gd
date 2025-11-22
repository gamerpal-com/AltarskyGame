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

@onready var cam: Camera2D = $Camera2D
@onready var player := $Player

var zoom_levels: Array[float] = []
var zoom_index: int = 0

# Zoom/Zone status labels
@onready var zoom_status: Label = $UI/ZoomStatus
@onready var zone_status: Label = $UI/ZoneStatus


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

	print("Player start zone: ", start_zone_text)

	if zone_status:
		zone_status.text = "Zone: " + start_zone_text

	# ✅ Connect zone change signal so handler gets called
	player.zone_changed.connect(_on_player_zone_changed)

	# --- Existing auth logic ---
	if AuthManager.is_logged_in:
		print("Using persisted session.")
		schedule_refresh_timer(60)  # 60s buffer before expiry
	else:
		_guest_login()


func _process(_delta: float) -> void:
	# Press Space / Enter (ui_accept) to cycle zoom
	if Input.is_action_just_pressed("ui_accept"):
		zoom_index += 1
		if zoom_index >= zoom_levels.size():
			zoom_index = 0

		var target_zoom: float = zoom_levels[zoom_index]
		print("Zoom switched to: ", target_zoom)

		# 1) change zoom
		tween_zoom(target_zoom)
		# 2) snap player to bottom-center within the new clamp
		player.snap_to_bottom_center(get_snap_offset_for_current_zoom())

	# Always keep margins & zone splits in sync with current zoom
	apply_margins_for_current_zoom()
	apply_zone_splits_for_current_zoom()

	# Always request redraw – _draw() will decide whether to show zones or not
	queue_redraw()


func schedule_refresh_timer(buffer_seconds: int = 60) -> void:
	if not AuthManager.is_logged_in:
		if not refresh_timer.is_stopped():
			refresh_timer.stop()
		return

	var secs_left: int = AuthManager.get_seconds_until_expiry()
	print("JWT seconds until expiry:", secs_left)

	if secs_left <= buffer_seconds:
		print("JWT expires soon or already expired → refreshing immediately.")
		refresh_jwt()
		return

	var wait_time: int = secs_left - buffer_seconds
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
			print("Refresh token invalid → clearing session and doing new guest login.")
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

	print("Refresh OK! New JWT:", AuthManager.jwt)
	schedule_refresh_timer(60)


func _on_refresh_timer_timeout() -> void:
	print("RefreshTimer timeout → re-checking JWT.")
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
	print("Player moved into ", zone_name, " zone")

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

	print("Debug zones: ", state_text)
