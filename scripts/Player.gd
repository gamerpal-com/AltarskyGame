extends Node2D

#Player movement speed for wasd and arrow control speed.
@export var move_speed: float = 500.0

#Exported Variables for player margin, note these are fallback margins,
#Should be left alone, use main node for margins
@export var margin_left: float = 16.0
@export var margin_right: float = 16.0
@export var margin_top: float = 24.0
@export var margin_bottom: float = 96.0

@export var camera: Camera2D   # assign this in the inspector!

# exported variables for screen zoning
@export_group("Horizontal Zones (0-1 across visible width)")
@export_range(0.0, 1.0) var zone_split_left: float = 0.33
@export_range(0.0, 1.0) var zone_split_right: float = 0.66
@export var debug_draw_zones: bool = false

signal zone_changed(old_zone: int, new_zone: int)

enum Zone { LEFT, MIDDLE, RIGHT }
var current_zone: int = Zone.MIDDLE

#Player shooting variables
@export_group("Shooting")
@export var bullet_scene: PackedScene              # assign a Bullet.tscn in inspector
@export var bullet_speed: float = 1200.0
@export var fire_interval: float = 0.08            # seconds between shots while holding
@export var bullet_lifetime: float = 1.2
@export var bullet_scale: float = 1.0              # 1.0 = normal size

@export_group("Special Input")
@export var double_tap_max_delay: float = 0.25     # seconds between taps
@export var two_finger_max_delay: float = 0.25
# NEW: hard cap on bullets per second (for spam / macros)
@export var max_shots_per_second: int = 15




#Variables for mouse and touch tracking
var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO


# Shooting state
var is_shooting: bool = false
var _fire_cooldown: float = 0.0
# 🔹 NEW: per-second cap bookkeeping
var _shots_second_timer: float = 0.0
var _shots_this_second: int = 0

# Touch bookkeeping for shoot + special detection
var _active_touch_count: int = 0
var _last_primary_tap_time: float = -1.0
var _last_primary_tap_pos: Vector2 = Vector2.ZERO
var _last_two_finger_time: float = -1.0
var _active_touch_ids: Array[int] = []


#ScreenZoning adjsut for zoom 
func set_zone_splits(left: float, right: float) -> void:
	zone_split_left = left
	zone_split_right = right


func _ready() -> void:
	physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_OFF
	print("Player ready() – movement script loaded. Camera:", camera)
	# DO NOT set position here anymore.
	# DO NOT call _update_zone() here.
	# Main.gd handles all initial placement and zone initialization.


func _unhandled_input(event: InputEvent) -> void:
	# ---------- MOUSE (PC) ----------
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# start drag + shooting
				is_dragging = true
				is_shooting = true

				var mouse_world: Vector2 = get_global_mouse_position()
				drag_offset = global_position - mouse_world
				Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)

				# detect double-click as SPECIAL 1
				var now := Time.get_ticks_msec() * 0.001
				if now - _last_primary_tap_time <= double_tap_max_delay:
					GlobalLogger.log("SPECIAL 1: single-finger double tap")

					_last_primary_tap_time = -1.0
				else:
					_last_primary_tap_time = now
					_last_primary_tap_pos = mouse_world
			else:
				# stop drag + shooting
				is_dragging = false
				is_shooting = false
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			# LEFT + RIGHT pressed together = SPECIAL 2
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				GlobalLogger.log("SPECIAL 2: mouse left+right combo / two-finger tap")

	if event is InputEventMouseMotion and is_dragging:
		var mouse_world: Vector2 = get_global_mouse_position()
		var target_pos: Vector2 = mouse_world + drag_offset
		global_position = _clamp_to_screen(target_pos)
		_update_zone()

	# ---------- TOUCH (MOBILE) ----------
	if event is InputEventScreenTouch:
		if event.pressed:
			# track touches
			if not _active_touch_ids.has(event.index):
				_active_touch_ids.append(event.index)
				_active_touch_count += 1

			# start shooting if any touch active
			is_dragging = true        # same gesture as move
			is_shooting = true

			var touch_world: Vector2 = get_global_mouse_position()
			drag_offset = global_position - touch_world

			var now_t := Time.get_ticks_msec() * 0.001

			if _active_touch_count == 1:
				# single-finger tap: check for double-tap SPECIAL 1
				if now_t - _last_primary_tap_time <= double_tap_max_delay:
					print("SPECIAL 1: single-finger double tap")
					_last_primary_tap_time = -1.0
				else:
					_last_primary_tap_time = now_t
					_last_primary_tap_pos = touch_world
			elif _active_touch_count == 2:
				# two fingers became active within window → SPECIAL 2
				if now_t - _last_two_finger_time <= two_finger_max_delay:
					GlobalLogger.log("SPECIAL 2: two-finger tap")
				_last_two_finger_time = now_t
		else:
			# touch released
			if _active_touch_ids.has(event.index):
				_active_touch_ids.erase(event.index)
				_active_touch_count = max(_active_touch_count - 1, 0)

			if _active_touch_count == 0:
				is_dragging = false
				is_shooting = false
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventScreenDrag and is_dragging:
		var drag_world: Vector2 = get_global_mouse_position()
		var target_pos_t: Vector2 = drag_world + drag_offset
		global_position = _clamp_to_screen(target_pos_t)
		_update_zone()


func _process(delta: float) -> void:
	var moving := false

	# ---------- Keyboard movement (when not dragging) ----------
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
			_update_zone()

	# ---------- Drag / touch movement counts as movement ----------
	if is_dragging:
		moving = true

	# If you’re tracking active touches, that also counts as "moving/aiming"
	if _active_touch_count > 0:
		moving = true

	# ---------- Shooting control based on movement ----------
	if moving:
		is_shooting = true
	else:
		is_shooting = false
		# reset cooldown + per-second counters so shots don't buffer
		_fire_cooldown = 0.0
		_shots_second_timer = 0.0
		_shots_this_second = 0

	# ---------- Per-second shot window (for spam/macro protection) ----------
	_shots_second_timer += delta
	if _shots_second_timer >= 1.0:
		_shots_second_timer -= 1.0
		_shots_this_second = 0

	# ---------- Continuous firing while shooting ----------
	if is_shooting and bullet_scene != null and _shots_this_second < max_shots_per_second:
		_fire_cooldown -= delta
		if _fire_cooldown <= 0.0:
			_fire_cooldown += fire_interval
			_spawn_bullet()
			_shots_this_second += 1



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
	
	#Inserted into clamping codeblock but is for screen zoning
func _update_zone() -> void:
	if camera == null:
		return

	# 1) Viewport / camera info
	var rect: Rect2 = get_viewport().get_visible_rect()
	var screen_w: float = rect.size.x

	var z: Vector2 = camera.zoom
	var half_w: float = (screen_w * 0.5) / z.x

	var cam_pos: Vector2 = camera.global_position
	var world_left: float = cam_pos.x - half_w
	var world_right: float = cam_pos.x + half_w

	# 2) World-space zone boundaries (same math as overlay)
	var split1_world: float = lerp(world_left, world_right, zone_split_left)
	var split2_world: float = lerp(world_left, world_right, zone_split_right)

	# 3) Decide which zone player is in, using world X
	var px: float = global_position.x
	var new_zone: int

	if px < split1_world:
		new_zone = Zone.LEFT
	elif px < split2_world:
		new_zone = Zone.MIDDLE
	else:
		new_zone = Zone.RIGHT

	# 4) Emit signal only when zone actually changes
	if new_zone != current_zone:
		var old := current_zone
		current_zone = new_zone
		zone_changed.emit(old, new_zone)


func reclamp_to_screen() -> void:
	global_position = _clamp_to_screen(global_position)

func snap_to_bottom_center(offset_bottom: float = 20.0) -> void:
	var rect: Rect2 = get_viewport().get_visible_rect()

	if camera == null:
		# fallback: same as initial spawn logic
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

	# use the param instead of hard-coded 20.0
	var desired_y: float = bottom_world - margin_bottom - offset_bottom

	var target := Vector2(center_x, desired_y)
	global_position = _clamp_to_screen(target)
		# Re-evaluate which zone we're in after snapping
	_update_zone()
	
	
	###############Player Bullet function Section #################
func _spawn_bullet() -> void:
	if bullet_scene == null:
		return

	var bullet := bullet_scene.instantiate()
	if bullet == null:
		return

	# Spawn at player's center (no vertical offset)
	bullet.global_position = global_position

	# These will either set real variables (if defined in bullet.gd)
	# or just create them dynamically at runtime - both are fine.
	bullet.velocity = Vector2(0, -1) * bullet_speed
	bullet.lifetime = bullet_lifetime

	# If the bullet is a Node2D, we can safely scale it
	if bullet is Node2D:
		(bullet as Node2D).scale = Vector2.ONE * bullet_scale

	# Add to the current scene so it actually appears & updates
	get_tree().current_scene.add_child(bullet)
