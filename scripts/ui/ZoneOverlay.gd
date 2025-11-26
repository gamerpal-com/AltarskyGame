extends Node2D

@export var camera: Camera2D
@export var player: Node2D
@export var main: Node  # to read debug_show_zones

func _process(_delta: float) -> void:
	# Request redraw every frame (cheap enough for a debug overlay)
	queue_redraw()

func _draw() -> void:
	if main == null or player == null or camera == null:
		return

	# Single source of truth: read the flag from Main
	if not main.debug_show_zones:
		return

	var rect: Rect2 = get_viewport().get_visible_rect()
	var screen_size: Vector2 = rect.size

	var z: Vector2 = camera.zoom
	var half_w: float = (screen_size.x * 0.5) / z.x
	var half_h: float = (screen_size.y * 0.5) / z.y

	var cam_pos: Vector2 = camera.global_position
	var world_left: float = cam_pos.x - half_w
	var world_right: float = cam_pos.x + half_w
	var world_top: float = cam_pos.y - half_h
	var world_bottom: float = cam_pos.y + half_h
	var height: float = world_bottom - world_top

	# Player still owns the split values
	var split1_x: float = lerp(world_left, world_right, player.zone_split_left)
	var split2_x: float = lerp(world_left, world_right, player.zone_split_right)

	var col_left := Color(0.0, 1.0, 1.0, 0.45)
	var col_mid := Color(0.0, 1.0, 0.0, 0.45)
	var col_right := Color(1.0, 0.0, 1.0, 0.45)

	# left
	draw_rect(
		Rect2(
			Vector2(world_left, world_top),
			Vector2(split1_x - world_left, height)
		),
		col_left,
		true
	)

	# middle
	draw_rect(
		Rect2(
			Vector2(split1_x, world_top),
			Vector2(split2_x - split1_x, height)
		),
		col_mid,
		true
	)

	# right
	draw_rect(
		Rect2(
			Vector2(split2_x, world_top),
			Vector2(world_right - split2_x, height)
		),
		col_right,
		true
	)

	var line_color := Color(1, 1, 1, 0.9)
	draw_line(Vector2(split1_x, world_top), Vector2(split1_x, world_bottom), line_color, 3.0)
	draw_line(Vector2(split2_x, world_top), Vector2(split2_x, world_bottom), line_color, 3.0)
