extends TextureButton

func _pressed() -> void:
	var main := get_tree().current_scene
	if main and main.has_method("toggle_debug_zones"):
		main.toggle_debug_zones()
