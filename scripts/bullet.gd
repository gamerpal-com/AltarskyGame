extends Node2D

var velocity: Vector2 = Vector2.ZERO
var lifetime: float = 1.0

func _process(delta: float) -> void:
	global_position += velocity * delta
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()
