extends Node2D

# ========= Movement / clamp =========
@export var move_speed: float = 500.0

@export var margin_left: float = 16.0
@export var margin_right: float = 16.0
@export var margin_top: float = 24.0
@export var margin_bottom: float = 96.0

@export var camera: Camera2D

# ========= Zones =========
@export_group("Horizontal Zones (0-1 across visible width)")
@export_range(0.0, 1.0) var zone_split_left: float = 0.33
@export_range(0.0, 1.0) var zone_split_right: float = 0.66
@export var debug_draw_zones: bool = false

signal zone_changed(old_zone: int, new_zone: int)

enum Zone { LEFT, MIDDLE, RIGHT }
var current_zone: int = Zone.MIDDLE

# ========= Shooting =========
@export_group("Shooting")
@export var bullet_scene: PackedScene
@export var bullet_speed: float = 600.0
@export var fire_interval: float = 0.08
@export var bullet_lifetime: float = 4.0
@export var bullet_scale: float = 2.0

@export_group("Special Input")
@export var double_tap_max_delay: float = 0.25
@export var space_double_tap_max_delay: float = 0.35
@export var max_shots_per_second: int = 15

# drag / touch
var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO

# shooting state
var is_shooting: bool = false
var _fire_cooldown: float = 0.0
var _shots_second_timer: float = 0.0
var _shots_this_second: int = 0

# touch bookkeeping
var _active_touch_ids: Array[int] = []
var _active_touch_count: int = 0

# Two-finger tap window (mobile specials)
var _two_finger_tap_count: int = 0
var _two_finger_window_deadline: float = 0.0

# Spacebar tap window (PC specials)
var _space_tap_count: int = 0
var _space_window_deadline: float = 0.0

@export var special_cooldown: float = 1.0 # seconds
var _special_cooldown_time_left: float = 0.0

# ========= Zone setup from Main =========
func set_zone_splits(left: float, right: float) -> void:
	zone_split_left = left
	zone_split_right = right

func _ready() -> void:
	physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_OFF
	print("Player ready() – movement script loaded. Camera:", camera)

########### Controls Section #############

# ========= INPUT HELPERS =========
func _register_two_finger_tap(now: float) -> void:
	if _special_cooldown_time_left > 0.0:
		return

	if now > _two_finger_window_deadline:
		_two_finger_tap_count = 1
		_two_finger_window_deadline = now + double_tap_max_delay
	else:
		_two_finger_tap_count += 1

func _register_space_tap(now: float) -> void:
	if _special_cooldown_time_left > 0.0:
		return

	if now > _space_window_deadline:
		_space_tap_count = 1
		_space_window_deadline = now + space_double_tap_max_delay
	else:
		_space_tap_count += 1

func _trigger_special1(context: String) -> void:
	GlobalLogger.log("SPECIAL 1: %s" % context)

func _trigger_special2(context: String) -> void:
	GlobalLogger.log("SPECIAL 2: %s" % context)

# ========= INPUT =========
func _input(event: InputEvent) -> void:
	# ---------- MOUSE (PC) ----------
	if event is InputEventMouseButton and not OS.has_feature("mobile"):
		var mb := event as InputEventMouseButton

		if mb.button_index == MOUSE_BUTTON_LEFT:
			if mb.pressed:
				is_dragging = true
				is_shooting = true

				var mouse_world: Vector2 = get_global_mouse_position()
				drag_offset = global_position - mouse_world
				Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
			else:
				is_dragging = false
				is_shooting = false
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseMotion and is_dragging and not OS.has_feature("mobile"):
		var mouse_world2: Vector2 = get_global_mouse_position()
		var target_pos: Vector2 = mouse_world2 + drag_offset
		global_position = _clamp_to_screen(target_pos)
		update_zone()

	# ---------- TOUCH (MOBILE) ----------
	if event is InputEventScreenTouch:
		var touch := event as InputEventScreenTouch
		var now_t := Time.get_ticks_msec() * 0.001

		if touch.pressed:
			if not _active_touch_ids.has(touch.index):
				_active_touch_ids.append(touch.index)
				_active_touch_count += 1

			is_dragging = true
			is_shooting = true

			var touch_world: Vector2 = get_global_mouse_position()
			drag_offset = global_position - touch_world

			if _active_touch_count == 2:
				_register_two_finger_tap(now_t)
		else:
			if _active_touch_ids.has(touch.index):
				_active_touch_ids.erase(touch.index)
				_active_touch_count = max(_active_touch_count - 1, 0)

			if _active_touch_count == 0:
				is_dragging = false
				is_shooting = false
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventScreenDrag and is_dragging:
		var drag_world: Vector2 = get_global_mouse_position()
		var target_pos_t: Vector2 = drag_world + drag_offset
		global_position = _clamp_to_screen(target_pos_t)
		update_zone()

# ========= PROCESS =========
func _process(delta: float) -> void:
	var now := Time.get_ticks_msec() * 0.001

	if not OS.has_feature("mobile") and Input.is_action_just_pressed("special"):
		_register_space_tap(now)

	if _special_cooldown_time_left > 0.0:
		_special_cooldown_time_left -= delta
		if _special_cooldown_time_left < 0.0:
			_special_cooldown_time_left = 0.0

	if _two_finger_window_deadline > 0.0 and now >= _two_finger_window_deadline:
		if _special_cooldown_time_left <= 0.0:
			if _two_finger_tap_count == 1:
				_trigger_special1("double-finger tap")
				_special_cooldown_time_left = special_cooldown
			elif _two_finger_tap_count >= 2:
				_trigger_special2("double double-finger tap")
				_special_cooldown_time_left = special_cooldown

		_two_finger_tap_count = 0
		_two_finger_window_deadline = 0.0

	if _space_window_deadline > 0.0 and now >= _space_window_deadline:
		if _special_cooldown_time_left <= 0.0:
			if _space_tap_count == 1:
				_trigger_special1("space tap")
				_special_cooldown_time_left = special_cooldown
			elif _space_tap_count >= 2:
				_trigger_special2("space double tap")
				_special_cooldown_time_left = special_cooldown

		_space_tap_count = 0
		_space_window_deadline = 0.0

	var moving := false

	# Keyboard movement when not dragging
	if not is_dragging:
		var dir := Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		)

		if dir != Vector2.ZERO:
			moving = true
			dir = dir.normalized()
			var target := global_position + dir * move_speed * delta
			global_position = _clamp_to_screen(target)
			update_zone()

	if is_dragging:
		moving = true
	if _active_touch_count > 0:
		moving = true

	if moving:
		is_shooting = true
	else:
		is_shooting = false
		_fire_cooldown = 0.0
		_shots_second_timer = 0.0
		_shots_this_second = 0

	_shots_second_timer += delta
	if _shots_second_timer >= 1.0:
		_shots_second_timer -= 1.0
		_shots_this_second = 0

	if is_shooting and bullet_scene == null:
		push_warning("Player: bullet_scene is null; assign a PackedScene in the inspector.")

	if is_shooting and bullet_scene != null and _shots_this_second < max_shots_per_second:
		_fire_cooldown -= delta
		if _fire_cooldown <= 0.0:
			_fire_cooldown += fire_interval
			_spawn_bullet()
			_shots_this_second += 1

# ========= Clamp / zones =========
func set_clamp_margins(left: float, right: float, top: float, bottom: float) -> void:
	margin_left = left
	margin_right = right
	margin_top = top
	margin_bottom = bottom

func _clamp_to_screen(target_pos: Vector2) -> Vector2:
	var rect: Rect2 = get_viewport().get_visible_rect()
	var screen_size: Vector2 = rect.size

	if camera == null:
		var min_x_f: float = rect.position.x + margin_left
		var max_x_f: float = rect.position.x + rect.size.x - margin_right
		var min_y_f: float = rect.position.y + margin_top
		var max_y_f: float = rect.position.y + rect.size.y - margin_bottom

		target_pos.x = clampf(target_pos.x, min_x_f, max_x_f)
		target_pos.y = clampf(target_pos.y, min_y_f, max_y_f)
		return target_pos

	var cam_pos: Vector2 = camera.global_position
	var z: Vector2 = camera.zoom

	var visible_half_w: float = (screen_size.x * 0.5) / z.x
	var visible_half_h: float = (screen_size.y * 0.5) / z.y

	var min_x: float = cam_pos.x - visible_half_w + margin_left
	var max_x: float = cam_pos.x + visible_half_w - margin_right
	var min_y: float = cam_pos.y - visible_half_h + margin_top
	var max_y: float = cam_pos.y + visible_half_h - margin_bottom

	target_pos.x = clampf(target_pos.x, min_x, max_x)
	target_pos.y = clampf(target_pos.y, min_y, max_y)
	return target_pos

func update_zone() -> void:
	if camera == null:
		return

	var rect: Rect2 = get_viewport().get_visible_rect()
	var screen_w: float = rect.size.x

	var z: Vector2 = camera.zoom
	var half_w: float = (screen_w * 0.5) / z.x

	var cam_pos: Vector2 = camera.global_position
	var world_left: float = cam_pos.x - half_w
	var world_right: float = cam_pos.x + half_w

	var split1_world: float = lerp(world_left, world_right, zone_split_left)
	var split2_world: float = lerp(world_left, world_right, zone_split_right)

	var px: float = global_position.x
	var new_zone: int

	if px < split1_world:
		new_zone = Zone.LEFT
	elif px < split2_world:
		new_zone = Zone.MIDDLE
	else:
		new_zone = Zone.RIGHT

	if new_zone != current_zone:
		var old := current_zone
		current_zone = new_zone
		zone_changed.emit(old, new_zone)

func reclamp_to_screen() -> void:
	global_position = _clamp_to_screen(global_position)

func snap_to_bottom_center(offset_bottom: float = 20.0) -> void:
	var rect: Rect2 = get_viewport().get_visible_rect()

	if camera == null:
		var start_x: float = rect.position.x + rect.size.x * 0.5
		var start_y: float = rect.position.y + rect.size.y * 0.8
		global_position = Vector2(start_x, start_y)
		return

	var screen_size: Vector2 = rect.size
	var cam_pos: Vector2 = camera.global_position
	var z: Vector2 = camera.zoom

	var visible_half_h: float = (screen_size.y * 0.5) / z.y

	var center_x: float = cam_pos.x
	var bottom_world: float = cam_pos.y + visible_half_h

	var desired_y: float = bottom_world - margin_bottom - offset_bottom

	var target := Vector2(center_x, desired_y)
	global_position = _clamp_to_screen(target)
	update_zone()

# ========= Bullets =========
func _spawn_bullet() -> void:
	if bullet_scene == null:
		return

	var bullet := bullet_scene.instantiate()
	if bullet == null:
		return

	bullet.global_position = global_position
	bullet.velocity = Vector2(0, -1) * bullet_speed
	bullet.lifetime = bullet_lifetime

	if bullet is Node2D:
		(bullet as Node2D).scale = Vector2.ONE * bullet_scale

	get_tree().current_scene.add_child(bullet)
