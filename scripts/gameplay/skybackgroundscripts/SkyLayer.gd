extends Control

@onready var prototype: TextureRect = $CloudPrototype

# Inspector exposure control variables
@export var layer_id := 10
@export var layer_name := "Far Layer"

@export var scroll_direction := Vector2.DOWN
@export var scroll_speed := 50.0
@export_range(0.0, 1.0) var layer_opacity := 1.0

@export var min_scale := 0.7
@export var max_scale := 1.3

@export var min_opacity := 0.3
@export var max_opacity := 1.0

@export var max_rotation_degrees := 0.0

# Layer Object Spawn Variables
@export var spawn_area_width := 1080.0
@export var spawn_area_height := 1920.0

@export var spawn_padding := 300.0
@export var spawn_spread := 900.0

@export var min_spawn_distance := 500.0
@export var max_spawn_attempts := 12

# Jitter to mathematically randomize the spawn interval function.
@export_range(0.0, 1.0) var spawn_jitter := 0.10

# This is now the fixed pool size for this layer.
@export var max_active_assets := 5

# ============================================================
# Per-Asset Movement
#
# Allows each spawned object to have its own movement behavior.
#
# Example:
# - Clouds can gently drift left or right.
# - Islands can disable horizontal drift and move only vertically.
# ============================================================

@export_group("Per-Asset Movement")
@export var use_per_asset_movement := true

@export var allow_horizontal_drift := true
@export_range(0.0, 1.0) var inward_drift_chance := 0.85
@export var horizontal_drift_strength := 0.35

@export var allow_speed_variance := true
@export var min_asset_speed_multiplier := 0.85
@export var max_asset_speed_multiplier := 1.15

func _ready() -> void:
	z_index = layer_id
	modulate.a = layer_opacity

	if prototype:
		prototype.visible = false
		_spawn_initial_pool()


func _process(delta: float) -> void:
	for child in get_children():
		if child == prototype:
			continue

		var asset_direction: Vector2 = child.get_meta(
			"move_direction",
			scroll_direction.normalized()
		)

		var asset_speed_multiplier: float = child.get_meta(
			"speed_multiplier",
			1.0
		)

		child.position += asset_direction * scroll_speed * asset_speed_multiplier * delta
		_recycle_if_needed(child)

## Creates the fixed scrolling pool and spreads assets across the movement path.
func _spawn_initial_pool() -> void:
	for i in range(max_active_assets):
		var instance := prototype.duplicate()
		instance.name = "%s_%s" % [layer_name, i]
		instance.visible = true
		add_child(instance)

		_randomize_asset(instance)
		instance.position = _get_seeded_spawn_position(i, max_active_assets, instance)
		_assign_asset_movement(instance)

### Spreads initial assets across the full travel path to prevent spawn gaps.
func _get_seeded_spawn_position(index: int, total: int, node: Control) -> Vector2:
	var dir: Vector2 = scroll_direction.normalized()
	var t: float = float(index) / maxf(1.0, float(total - 1))

	var jitter: float = randf_range(-spawn_jitter, spawn_jitter)
	t = clampf(t + jitter, 0.0, 1.0)

	# Vertical movement dominates.
	if abs(dir.y) >= abs(dir.x):
		var travel_start: float = -spawn_padding - spawn_spread
		var travel_end: float = spawn_area_height + spawn_padding
		var y: float = lerpf(travel_start, travel_end, t)

		if dir.y < 0.0:
			travel_start = spawn_area_height + spawn_padding + spawn_spread
			travel_end = -spawn_padding
			y = lerpf(travel_start, travel_end, t)

		return Vector2(_get_random_x_for_node(node), y)

	# Horizontal movement dominates.
	var h_travel_start: float = -spawn_padding - spawn_spread
	var h_travel_end: float = spawn_area_width + spawn_padding
	var x: float = lerpf(h_travel_start, h_travel_end, t)

	if dir.x < 0.0:
		h_travel_start = spawn_area_width + spawn_padding + spawn_spread
		h_travel_end = -spawn_padding
		x = lerpf(h_travel_start, h_travel_end, t)

	return Vector2(x, _get_random_y_for_node(node))

	##tracks spawn position of objects
func _get_spawn_position(node: Control) -> Vector2:
	for attempt in range(max_spawn_attempts):
		var pos := _get_raw_spawn_position(node)

		if not _is_too_close_to_other_assets(pos, min_spawn_distance):
			return pos

	return _get_raw_spawn_position(node)

## Returns spawn position based on the layer's movement direction.
func _get_raw_spawn_position(node: Control) -> Vector2:
	var dir := scroll_direction.normalized()

	# Vertical movement dominates.
	if abs(dir.y) >= abs(dir.x):
		if dir.y > 0.0:
			return Vector2(
				_get_random_x_for_node(node),
				randf_range(-spawn_padding - spawn_spread, -spawn_padding)
			)

		return Vector2(
			_get_random_x_for_node(node),
			randf_range(
				spawn_area_height + spawn_padding,
				spawn_area_height + spawn_padding + spawn_spread
			)
		)

	# Horizontal movement dominates.
	if dir.x > 0.0:
		return Vector2(
			randf_range(-spawn_padding - spawn_spread, -spawn_padding),
			_get_random_y_for_node(node)
		)

	return Vector2(
		randf_range(
			spawn_area_width + spawn_padding,
			spawn_area_width + spawn_padding + spawn_spread
		),
		_get_random_y_for_node(node)
	)


## Prevents the visual right-side bias caused by TextureRect top-left positioning.
func _get_random_x_for_node(node: Control) -> float:
	var node_width := node.size.x * node.scale.x
	return randf_range(-node_width * 0.5, spawn_area_width - node_width * 0.5)


func _get_random_y_for_node(node: Control) -> float:
	var node_height := node.size.y * node.scale.y
	return randf_range(-node_height * 0.5, spawn_area_height - node_height * 0.5)


## Recycles assets that move beyond the configured spawn bounds.
func _recycle_if_needed(node: Control) -> void:
	var node_width: float = node.size.x * node.scale.x
	var node_height: float = node.size.y * node.scale.y

	var left_limit: float = -spawn_padding - node_width
	var right_limit: float = spawn_area_width + spawn_padding
	var top_limit: float = -spawn_padding - node_height
	var bottom_limit: float = spawn_area_height + spawn_padding

	var dir := scroll_direction.normalized()

	if dir.x > 0.0 and node.position.x > right_limit:
		_randomize_asset(node)
		node.position = _get_spawn_position(node)
		_assign_asset_movement(node)
		return

	if dir.x < 0.0 and node.position.x < left_limit:
		_randomize_asset(node)
		node.position = _get_spawn_position(node)
		_assign_asset_movement(node)
		return

	if dir.y > 0.0 and node.position.y > bottom_limit:
		_randomize_asset(node)
		node.position = _get_spawn_position(node)
		_assign_asset_movement(node)
		return

	if dir.y < 0.0 and node.position.y < top_limit:
		_randomize_asset(node)
		node.position = _get_spawn_position(node)
		_assign_asset_movement(node)
		return


## Randomizes one spawned asset when it is created or recycled.
func _randomize_asset(node: Control) -> void:
	var random_scale: float = randf_range(min_scale, max_scale)
	node.scale = Vector2(random_scale, random_scale)

	node.modulate.a = randf_range(min_opacity, max_opacity)

	node.rotation_degrees = randf_range(
		-max_rotation_degrees,
		max_rotation_degrees
	)
	
## Minimal distance tracking between spawned objects
func _is_too_close_to_other_assets(pos: Vector2, min_distance: float) -> bool:
	for child in get_children():
		if child == prototype:
			continue

		var child_width: float = child.size.x * child.scale.x
		var child_height: float = child.size.y * child.scale.y

		var child_center: Vector2 = child.position + Vector2(child_width * 0.5, child_height * 0.5)
		var test_center: Vector2 = pos

		if child_center.distance_to(test_center) < min_distance:
			return true

	return false

	# ============================================================
# Per-Asset Movement Assignment
#
# Called whenever an object is created or recycled.
#
# This gives each object its own movement direction and speed.
# The layer still controls the overall behavior, but individual
# assets can feel more natural.
# ============================================================

func _assign_asset_movement(node: Control) -> void:
	var direction := scroll_direction.normalized()

	if use_per_asset_movement and allow_horizontal_drift:
		direction = _get_side_aware_asset_direction(node)

	var speed_multiplier := 1.0

	if allow_speed_variance:
		speed_multiplier = randf_range(
			min_asset_speed_multiplier,
			max_asset_speed_multiplier
		)

	node.set_meta("move_direction", direction)
	node.set_meta("speed_multiplier", speed_multiplier)


# ============================================================
# Side-Aware Asset Direction
#
# Uses ScreenZoneHelper to check where the object spawned:
#
# Left side   -> usually drift right
# Middle      -> random left or right
# Right side  -> usually drift left
#
# This prevents clouds from spawning near an edge and immediately
# drifting off-screen.
# ============================================================
func _get_side_aware_asset_direction(node: Control) -> Vector2:
	var base_direction := scroll_direction.normalized()

	var center := _get_asset_center(node)

	var zone := ScreenZoneHelper.get_horizontal_zone(
		center.x,
		spawn_area_width
	)

	var horizontal_direction := 0.0

	match zone:
		ScreenZoneHelper.HorizontalZone.LEFT:
			horizontal_direction = 1.0 if randf() < inward_drift_chance else -1.0

		ScreenZoneHelper.HorizontalZone.MIDDLE:
			horizontal_direction = -1.0 if randf() < 0.5 else 1.0

		ScreenZoneHelper.HorizontalZone.RIGHT:
			horizontal_direction = -1.0 if randf() < inward_drift_chance else 1.0

	var final_direction := Vector2(
		horizontal_direction * horizontal_drift_strength,
		base_direction.y
	)

	if final_direction == Vector2.ZERO:
		return base_direction

	return final_direction.normalized()

	# ============================================================
# Asset Center Position
#
# Control nodes use top-left positioning.
#
# That means node.position is not the middle of the cloud.
# It is the upper-left corner.
#
# This helper finds the real center of the object, even when
# the object has been scaled larger or smaller.
#
# Example:
# If a cloud is 200px wide and scaled to 2.0,
# it is visually 400px wide.
#
# Its center is:
# position.x + 200
# ============================================================

func _get_asset_center(node: Control) -> Vector2:
	var scaled_size := Vector2(
		node.size.x * node.scale.x,
		node.size.y * node.scale.y
	)

	return node.position + scaled_size * 0.5

## Returns the layer ID for layer conflict checking.
func get_layer_id() -> int:
	return layer_id
