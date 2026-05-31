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

@export_group("Zones for 1.5x zoom")
@export_range(0.0, 1.0) var z15_left: float = 0.33
@export_range(0.0, 1.0) var z15_right: float = 0.66

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
@export var zoom_15x: float = 1.5
@export var zoom_2x: float = 2.0
@export var zoom_25x: float = 2.5
@export var zoom_3x: float = 3.0

@export_group("Margins for 1x zoom")
@export var m1_left: float = 24.0
@export var m1_right: float = 24.0
@export var m1_top: float = 140.0
@export var m1_bottom: float = 80.0

@export_group("Margins for 1.5x zoom")
@export var m15_left: float = 24.0
@export var m15_right: float = 24.0
@export var m15_top: float = 130.0
@export var m15_bottom: float = 80.0

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
@export var s2_bottom: float = 550.0
@export var s25_bottom: float = 100.0
@export var s3_bottom: float = 20.0
@export var s15_bottom: float = 285.0

# =========================
#  NON-EXPORTED NODES & STATE
# =========================
@onready var auth_service: AuthService = $AuthService

@onready var cam: Camera2D = $Camera2D
@onready var player := $Player

var zoom_levels: Array[float] = []
var zoom_index: int = 0

# Zoom/Zone status labels
@onready var ui: GameUI = $UI


func _ready() -> void:
	# --- Zoom setup ---
	zoom_levels = [
		zoom_1x,
		zoom_15x,
		zoom_2x,
		zoom_25x,
		zoom_3x,
	]

	zoom_index = 1
	set_zoom_immediate(zoom_levels[zoom_index])

	await get_tree().process_frame

	apply_zone_splits_for_current_zoom()
	apply_margins_for_current_zoom()

	player.snap_to_bottom_center(get_snap_offset_for_current_zoom())

	var z: float = zoom_levels[zoom_index]
	ui.update_zoom_label(z)

	player.update_zone()
	var start_zone_text := "MIDDLE"
	match player.current_zone:
		player.Zone.LEFT:
			start_zone_text = "LEFT"
		player.Zone.MIDDLE:
			start_zone_text = "MIDDLE"
		player.Zone.RIGHT:
			start_zone_text = "RIGHT"

	GlobalLogger.log("Player start zone: %s" % start_zone_text)

	ui.update_zone_label(start_zone_text)

	player.zone_changed.connect(_on_player_zone_changed)

	# --- Debug overlay & panel initial visibility ---
	ui.set_debug_visible(debug_show_zones)

	# --- Connect UI button signals ---
	if ui:
		if not ui.zoom_button_pressed.is_connected(cycle_zoom):
			ui.zoom_button_pressed.connect(cycle_zoom)

		if not ui.debug_button_pressed.is_connected(toggle_debug_zones):
			ui.debug_button_pressed.connect(toggle_debug_zones)


func _process(_delta: float) -> void:
	apply_margins_for_current_zoom()
	apply_zone_splits_for_current_zoom()
	# ZoneOverlay handles its own redraw now

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
		0: return s1_bottom
		1: return s15_bottom
		2: return s2_bottom
		3: return s25_bottom
		4: return s3_bottom
		_: return s1_bottom

func apply_margins_for_current_zoom() -> void:
	match zoom_index:
		0: player.set_clamp_margins(m1_left, m1_right, m1_top, m1_bottom)
		1: player.set_clamp_margins(m15_left, m15_right, m15_top, m15_bottom)
		2: player.set_clamp_margins(m2_left, m2_right, m2_top, m2_bottom)
		3: player.set_clamp_margins(m25_left, m25_right, m25_top, m25_bottom)
		4: player.set_clamp_margins(m3_left, m3_right, m3_top, m3_bottom)
		_: player.set_clamp_margins(m1_left, m1_right, m1_top, m1_bottom)

# =========================
#  ZONE SPLITS & OVERLAY
# =========================
func apply_zone_splits_for_current_zoom() -> void:
	match zoom_index:
		0: player.set_zone_splits(z1_left, z1_right)
		1: player.set_zone_splits(z15_left, z15_right)
		2: player.set_zone_splits(z2_left, z2_right)
		3: player.set_zone_splits(z25_left, z25_right)
		4: player.set_zone_splits(z3_left, z3_right)
		_: player.set_zone_splits(z1_left, z1_right)


func _on_player_zone_changed(_old_zone: int, new_zone: int) -> void:
	var zone_name := "MIDDLE"
	match new_zone:
		player.Zone.LEFT:
			zone_name = "LEFT"
		player.Zone.MIDDLE:
			zone_name = "MIDDLE"
		player.Zone.RIGHT:
			zone_name = "RIGHT"

	GlobalLogger.log("Player moved into %s zone" % zone_name)
	ui.update_zone_label(zone_name)

# =========================
#  BUTTON HELPERS
# =========================
func cycle_zoom() -> void:
	zoom_index = (zoom_index + 1) % zoom_levels.size()
	var new_zoom: float = zoom_levels[zoom_index]

	tween_zoom(new_zoom)
	apply_margins_for_current_zoom()
	apply_zone_splits_for_current_zoom()
	player.snap_to_bottom_center(get_snap_offset_for_current_zoom())

	ui.update_zoom_label(new_zoom)
	GlobalLogger.log("Zoom switched to: %s" % str(new_zoom))


func _update_zoom_status() -> void:
	var current_zoom: float = zoom_levels[zoom_index]
	ui.update_zoom_label(current_zoom)


func toggle_debug_zones() -> void:
	debug_show_zones = !debug_show_zones

	var state_text := "OFF"
	if debug_show_zones:
		state_text = "ON"

	GlobalLogger.log("Debug zones: %s" % state_text)

	ui.set_debug_visible(debug_show_zones)
