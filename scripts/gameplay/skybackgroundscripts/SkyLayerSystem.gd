extends Control

func _ready() -> void:
	_validate_layers()


func _validate_layers() -> void:
	var used_layer_ids := {}

	for child in get_children():
		if not child.has_method("get_layer_id"):
			continue

		var layer_id: int = child.get_layer_id()

		if used_layer_ids.has(layer_id):
			push_warning("SkyLayerSystem: Duplicate layer_id detected: %s" % layer_id)
		else:
			used_layer_ids[layer_id] = child.name

		child.z_index = layer_id