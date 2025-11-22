extends TextureButton

func _pressed() -> void:
	var main := get_tree().current_scene
	if main and main.has_method("cycle_zoom"):
		main.cycle_zoom()
