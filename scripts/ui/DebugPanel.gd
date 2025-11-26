extends Control

@onready var debug_log_view: RichTextLabel = $DebugLogView
@onready var debug_log_backdrop: ColorRect = $DebugLogBackdrop
@onready var debug_log_toggle: TextureButton = $LogToggle

func _ready() -> void:
	# Start with console hidden
	if is_instance_valid(debug_log_view):
		debug_log_view.visible = false
	if is_instance_valid(debug_log_backdrop):
		debug_log_backdrop.visible = false

	# Hook up logger → this panel
	if not is_instance_valid(debug_log_view):
		GlobalLogger.log("DebugPanel._ready: ERROR – debug_log_view is null, cannot connect log stream.")
	else:
		GlobalLogger.log("DebugPanel._ready: connecting GlobalLogger.log_appended → _on_log_appended")
		if not GlobalLogger.log_appended.is_connected(_on_log_appended):
			GlobalLogger.log_appended.connect(_on_log_appended)

		# Initialize with existing log text
		debug_log_view.text = GlobalLogger.get_all_text()
		var line_count := debug_log_view.get_line_count()
		if line_count > 0:
			debug_log_view.scroll_to_line(line_count - 1)

	# Ensure toggle button drives this panel
	if is_instance_valid(debug_log_toggle):
		if not debug_log_toggle.toggled.is_connected(_on_LogToggle_toggled):
			debug_log_toggle.toggled.connect(_on_LogToggle_toggled)

func _on_log_appended(_line: String) -> void:
	print("DEBUG: DebugPanel._on_log_appended fired: ", _line)

	if not is_instance_valid(debug_log_view):
		return

	debug_log_view.text = GlobalLogger.get_all_text()

	var line_count := debug_log_view.get_line_count()
	if line_count > 0:
		debug_log_view.scroll_to_line(line_count - 1)

func _on_LogToggle_toggled(pressed: bool) -> void:
	GlobalLogger.log("LogToggle toggled: %s" % pressed)

	if not is_instance_valid(debug_log_view):
		return

	debug_log_view.visible = pressed

	if is_instance_valid(debug_log_backdrop):
		debug_log_backdrop.visible = pressed

	if pressed:
		debug_log_view.text = GlobalLogger.get_all_text()
		var line_count := debug_log_view.get_line_count()
		if line_count > 0:
			debug_log_view.scroll_to_line(line_count - 1)
