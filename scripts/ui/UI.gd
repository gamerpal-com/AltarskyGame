extends CanvasLayer
class_name GameUI

@onready var debug_panel: Control = $DebugPanel
@onready var zoom_status: Label = $DebugPanel/ZoomStatus
@onready var zone_status: Label = $DebugPanel/ZoneStatus

func set_debug_visible(v: bool) -> void:
	if is_instance_valid(debug_panel):
		debug_panel.visible = v
		
func update_zoom_label(zoom: float) -> void:
	if is_instance_valid(zoom_status):
		zoom_status.text = "Zoom: %sx" % zoom

func update_zone_label(zone_name: String) -> void:
	if is_instance_valid(zone_status):
		zone_status.text = "Zone: %s" % zone_name
