extends CanvasLayer
class_name GameUI

signal zoom_button_pressed
signal debug_button_pressed

@onready var debug_panel: Control = $DebugPanel
@onready var zoom_status: Label = $DebugPanel/ZoomStatus
@onready var zone_status: Label = $DebugPanel/ZoneStatus
@onready var zoom_button: TextureButton = $DebugPanel/ZoomButton
@onready var debug_button: TextureButton = $DebugButton

func _ready() -> void:
	if is_instance_valid(zoom_button) and not zoom_button.pressed.is_connected(_on_zoom_button_pressed):
		zoom_button.pressed.connect(_on_zoom_button_pressed)

	if is_instance_valid(debug_button) and not debug_button.pressed.is_connected(_on_debug_button_pressed):
		debug_button.pressed.connect(_on_debug_button_pressed)

func set_debug_visible(v: bool) -> void:
	if is_instance_valid(debug_panel):
		debug_panel.visible = v
		
func update_zoom_label(zoom: float) -> void:
	if is_instance_valid(zoom_status):
		zoom_status.text = "Zoom: %sx" % zoom

func update_zone_label(zone_name: String) -> void:
	if is_instance_valid(zone_status):
		zone_status.text = "Zone: %s" % zone_name
		
		#Debug Button logic
func _on_zoom_button_pressed() -> void:
	zoom_button_pressed.emit()

func _on_debug_button_pressed() -> void:
	debug_button_pressed.emit()
