extends Control

# ============================================================
# Node References
#
# These connect this script to the UI nodes in UI_Main.tscn.
# ============================================================

@onready var debug_log_view: RichTextLabel = $DebugLogView
@onready var debug_log_backdrop: ColorRect = $DebugLogBackdrop
@onready var debug_log_toggle: TextureButton = $LogToggle

@onready var log_filter_controls: Control = $LogFilterControls

@onready var show_all_button: Button = $LogFilterControls/ShowAllButton
@onready var live_button: Button = $LogFilterControls/LiveButton
@onready var errors_button: Button = $LogFilterControls/ErrorsButton
@onready var warnings_button: Button = $LogFilterControls/WarningsButton
@onready var system_button: Button = $LogFilterControls/SystemButton
@onready var info_button: Button = $LogFilterControls/InfoButton
@onready var verbose_button: Button = $LogFilterControls/VerboseButton
@onready var refresh_logs_button: Button = $LogFilterControls/RefreshLogsButton


# ============================================================
# DebugPanel
#
# Displays GlobalLogger messages in-game.
#
# Main rule:
# The debugger must never hurt gameplay performance.
#
# How we protect performance:
# - Hidden console does no visual work.
# - Visible console loads logs progressively.
# - Live display is optional and off by default.
# - Only important logs are shown by default.
# - Show All can be enabled when deep debugging is needed.
# ============================================================


# ============================================================
# Log Filters
#
# These decide which log levels are allowed to appear.
#
# The logger still records everything.
# These only control what this panel displays.
# ============================================================

@export_group("Log Filters")
@export var show_errors := true
@export var show_warnings := true
@export var show_system := true
@export var show_info := false
@export var show_verbose := false
@export var show_all_logs := false


# ============================================================
# Display Behavior
#
# live_log_display:
# If false, the console acts like a snapshot viewer.
# This is safest for gameplay performance.
#
# refresh_snapshot_when_opened:
# If true, opening the console reloads the newest filtered logs.
# ============================================================

@export_group("Display Behavior")
@export var live_log_display := false
@export var refresh_snapshot_when_opened := true
@export var auto_scroll_log := true


# ============================================================
# Performance Controls
#
# These control how much debug UI work is allowed per update.
# ============================================================

@export_group("Performance")
@export var debug_log_refresh_interval := 1.0
@export var visible_log_line_limit := 25
@export var visible_log_overflow_limit := 25
@export var visible_log_trim_interval := 1.0

@export var progressive_log_load := true
@export var log_lines_per_load_step := 10
@export var progressive_load_interval := 0.05


# ============================================================
# Runtime State
#
# These are internal variables used while the game is running.
# They should not be edited directly in the Inspector.
# ============================================================

var debug_log_dirty := false
var debug_log_refresh_timer := 0.0

var debug_log_has_loaded_once := false
var showing_empty_log_message := false

var pending_live_log_lines: Array[Dictionary] = []
var pending_log_lines: Array[Dictionary] = []

var pending_log_index := 0
var progressive_load_timer := 0.0
var loading_log_progressively := false

var displayed_log_lines: Array[Dictionary] = []

var display_trim_dirty := false
var display_trim_timer := 0.0


func _ready() -> void:
	# Start with the debug console hidden.
	if is_instance_valid(debug_log_view):
		debug_log_view.visible = false

	if is_instance_valid(debug_log_backdrop):
		debug_log_backdrop.visible = false

	if is_instance_valid(log_filter_controls):
		log_filter_controls.visible = false

	# Connect GlobalLogger to this panel.
	#
	# Important:
	# Incoming logs do not directly rebuild the UI.
	# They either mark the display dirty or queue a line.
	if is_instance_valid(debug_log_view):
		if not GlobalLogger.log_appended.is_connected(_on_log_appended):
			GlobalLogger.log_appended.connect(_on_log_appended)

	# Connect the main console toggle button.
	if is_instance_valid(debug_log_toggle):
		if not debug_log_toggle.toggled.is_connected(_on_LogToggle_toggled):
			debug_log_toggle.toggled.connect(_on_LogToggle_toggled)

	# Connect filter buttons.
	_setup_filter_controls()

	# Make button labels clearly show ON/OFF state.
	_refresh_filter_button_labels()


func _process(delta: float) -> void:
	_update_progressive_log_load(delta)
	_update_debug_log_display(delta)
	_update_visible_log_trim(delta)


# ============================================================
# Filter Control Setup
#
# Connects the filter buttons to this script.
#
# The filter buttons should be normal Button nodes with:
# Button -> Toggle Mode = On
#
# RefreshLogsButton should be a normal Button, not a toggle.
# ============================================================

func _setup_filter_controls() -> void:
	if is_instance_valid(show_all_button):
		show_all_button.button_pressed = show_all_logs
		if not show_all_button.toggled.is_connected(_on_ShowAllButton_toggled):
			show_all_button.toggled.connect(_on_ShowAllButton_toggled)

	if is_instance_valid(live_button):
		live_button.button_pressed = live_log_display
		if not live_button.toggled.is_connected(_on_LiveButton_toggled):
			live_button.toggled.connect(_on_LiveButton_toggled)

	if is_instance_valid(errors_button):
		errors_button.button_pressed = show_errors
		if not errors_button.toggled.is_connected(_on_ErrorsButton_toggled):
			errors_button.toggled.connect(_on_ErrorsButton_toggled)

	if is_instance_valid(warnings_button):
		warnings_button.button_pressed = show_warnings
		if not warnings_button.toggled.is_connected(_on_WarningsButton_toggled):
			warnings_button.toggled.connect(_on_WarningsButton_toggled)

	if is_instance_valid(system_button):
		system_button.button_pressed = show_system
		if not system_button.toggled.is_connected(_on_SystemButton_toggled):
			system_button.toggled.connect(_on_SystemButton_toggled)

	if is_instance_valid(info_button):
		info_button.button_pressed = show_info
		if not info_button.toggled.is_connected(_on_InfoButton_toggled):
			info_button.toggled.connect(_on_InfoButton_toggled)

	if is_instance_valid(verbose_button):
		verbose_button.button_pressed = show_verbose
		if not verbose_button.toggled.is_connected(_on_VerboseButton_toggled):
			verbose_button.toggled.connect(_on_VerboseButton_toggled)

	if is_instance_valid(refresh_logs_button):
		refresh_logs_button.text = "Refresh"
		if not refresh_logs_button.pressed.is_connected(_on_RefreshLogsButton_pressed):
			refresh_logs_button.pressed.connect(_on_RefreshLogsButton_pressed)


# ============================================================
# Filter Button Labels
#
# Makes button state readable on mobile.
#
# Example:
# Errors ON
# Errors OFF
# ============================================================

func _refresh_filter_button_labels() -> void:
	if is_instance_valid(show_all_button):
		show_all_button.text = "All ON" if show_all_logs else "All OFF"

	if is_instance_valid(live_button):
		live_button.text = "Live ON" if live_log_display else "Live OFF"

	if is_instance_valid(errors_button):
		errors_button.text = "Errors ON" if show_errors else "Errors OFF"

	if is_instance_valid(warnings_button):
		warnings_button.text = "Warn ON" if show_warnings else "Warn OFF"

	if is_instance_valid(system_button):
		system_button.text = "System ON" if show_system else "System OFF"

	if is_instance_valid(info_button):
		info_button.text = "Info ON" if show_info else "Info OFF"

	if is_instance_valid(verbose_button):
		verbose_button.text = "Verb ON" if show_verbose else "Verb OFF"


# ============================================================
# Logger Signal Receiver
#
# This must stay cheap.
#
# The logger may receive many messages quickly.
# Do not touch RichTextLabel directly here.
# ============================================================

func _on_log_appended(line: Dictionary) -> void:
	if not _line_passes_filter(line):
		return

	if _is_debug_console_visible() and debug_log_has_loaded_once:
		if live_log_display:
			pending_live_log_lines.append(line)
		else:
			debug_log_dirty = true

		return

	debug_log_dirty = true


# ============================================================
# Debug Log Display Update
#
# Runs on a timer.
#
# This prevents the console from rebuilding text every frame.
# ============================================================

func _update_debug_log_display(delta: float) -> void:
	if not _is_debug_console_visible():
		return

	if loading_log_progressively:
		return

	debug_log_refresh_timer += delta

	if debug_log_refresh_timer < debug_log_refresh_interval:
		return

	debug_log_refresh_timer = 0.0

	if not debug_log_has_loaded_once and debug_log_dirty:
		_refresh_debug_log_view()
		debug_log_dirty = false
		return

	if live_log_display and pending_live_log_lines.size() > 0:
		_append_live_log_lines()


# ============================================================
# Refresh Debug Log View
#
# Loads a snapshot of recent filtered logs.
# ============================================================

func _refresh_debug_log_view() -> void:
	if not is_instance_valid(debug_log_view):
		return

	if progressive_log_load:
		_start_progressive_log_load()
		return

	displayed_log_lines = GlobalLogger.get_filtered_recent_lines(
		visible_log_line_limit,
		show_errors,
		show_warnings,
		show_system,
		show_info,
		show_verbose,
		show_all_logs
	)

	if displayed_log_lines.is_empty():
		_show_empty_log_message()
	else:
		_render_visible_log_buffer()

	debug_log_has_loaded_once = true
	debug_log_dirty = false


# ============================================================
# Empty Log Placeholder
#
# This is not stored in GlobalLogger.
#
# It only appears when the visible filtered log list is empty.
# It disappears automatically when real visible logs load.
# ============================================================

func _show_empty_log_message() -> void:
	if not is_instance_valid(debug_log_view):
		return

	debug_log_view.clear()
	debug_log_view.append_text("Debug console ready. No important logs yet.")
	showing_empty_log_message = true


# ============================================================
# Progressive Log Load Start
#
# Prepares snapshot loading in small chunks.
# ============================================================

func _start_progressive_log_load() -> void:
	if not is_instance_valid(debug_log_view):
		return

	pending_log_lines = GlobalLogger.get_filtered_recent_lines(
		visible_log_line_limit,
		show_errors,
		show_warnings,
		show_system,
		show_info,
		show_verbose,
		show_all_logs
	)

	if pending_log_lines.is_empty():
		_show_empty_log_message()
		loading_log_progressively = false
		debug_log_has_loaded_once = true
		debug_log_dirty = false
		return

	pending_log_index = 0
	progressive_load_timer = 0.0
	loading_log_progressively = true
	debug_log_has_loaded_once = false

	showing_empty_log_message = false
	displayed_log_lines.clear()
	debug_log_view.clear()


# ============================================================
# Progressive Log Load Update
#
# Loads a few lines at a time.
# ============================================================

func _update_progressive_log_load(delta: float) -> void:
	if not loading_log_progressively:
		return

	if not _is_debug_console_visible():
		loading_log_progressively = false
		return

	progressive_load_timer += delta

	if progressive_load_timer < progressive_load_interval:
		return

	progressive_load_timer = 0.0

	var lines_loaded := 0
	var batch_lines: Array[Dictionary] = []

	while pending_log_index < pending_log_lines.size() and lines_loaded < log_lines_per_load_step:
		batch_lines.append(pending_log_lines[pending_log_index])
		pending_log_index += 1
		lines_loaded += 1

	_append_lines_to_display(batch_lines)

	if pending_log_index >= pending_log_lines.size():
		loading_log_progressively = false
		debug_log_has_loaded_once = true
		debug_log_dirty = false
		_scroll_log_to_bottom()


# ============================================================
# Append Live Log Lines
#
# Used only when live_log_display is enabled.
# ============================================================

func _append_live_log_lines() -> void:
	var lines_loaded := 0
	var batch_lines: Array[Dictionary] = []

	while pending_live_log_lines.size() > 0 and lines_loaded < log_lines_per_load_step:
		batch_lines.append(pending_live_log_lines[0])
		pending_live_log_lines.remove_at(0)
		lines_loaded += 1

	_append_lines_to_display(batch_lines)


# ============================================================
# Visible Log Buffer
#
# The visible console has its own capped display buffer.
#
# GlobalLogger stores real history.
# DebugPanel only shows a filtered recent view.
# ============================================================

func _append_lines_to_display(lines: Array[Dictionary]) -> void:
	if lines.is_empty():
		return

	if showing_empty_log_message:
		debug_log_view.clear()
		showing_empty_log_message = false

	var batch_text := ""

	for line in lines:
		displayed_log_lines.append(line)

		if batch_text != "":
			batch_text += "\n"

		batch_text += str(line["text"])

	if batch_text == "":
		return

	if is_instance_valid(debug_log_view):
		if debug_log_view.get_parsed_text() != "":
			debug_log_view.append_text("\n" + batch_text)
		else:
			debug_log_view.append_text(batch_text)
		if live_log_display:
			_scroll_log_to_bottom()

	var max_allowed_lines := visible_log_line_limit + visible_log_overflow_limit

	if displayed_log_lines.size() > max_allowed_lines:
		display_trim_dirty = true


func _update_visible_log_trim(delta: float) -> void:
	if not display_trim_dirty:
		return

	if _is_debug_console_visible():
		display_trim_timer += delta

		if display_trim_timer < visible_log_trim_interval:
			return

		display_trim_timer = 0.0
		_trim_visible_log_buffer(true)
		return

	_trim_visible_log_buffer(false)


func _trim_visible_log_buffer(update_view: bool) -> void:
	while displayed_log_lines.size() > visible_log_line_limit:
		displayed_log_lines.remove_at(0)

	display_trim_dirty = false

	if update_view:
		_render_visible_log_buffer()


func _render_visible_log_buffer() -> void:
	if not is_instance_valid(debug_log_view):
		return

	if displayed_log_lines.is_empty():
		_show_empty_log_message()
		return

	showing_empty_log_message = false

	debug_log_view.clear()

	var text_lines := PackedStringArray()

	for line in displayed_log_lines:
		text_lines.append(str(line["text"]))

	debug_log_view.append_text("\n".join(text_lines))

	_scroll_log_to_bottom()

func _scroll_log_to_bottom() -> void:
	if not auto_scroll_log:
		return

	if not is_instance_valid(debug_log_view):
		return

	var line_count := debug_log_view.get_line_count()

	if line_count > 0:
		debug_log_view.scroll_to_line(line_count - 1)


# ============================================================
# Filter Helpers
# ============================================================

func _line_passes_filter(line: Dictionary) -> bool:
	if show_all_logs:
		return true

	if not line.has("level"):
		return true

	match int(line["level"]):
		GlobalLogger.LogLevel.ERROR:
			return show_errors
		GlobalLogger.LogLevel.WARNING:
			return show_warnings
		GlobalLogger.LogLevel.SYSTEM:
			return show_system
		GlobalLogger.LogLevel.INFO:
			return show_info
		GlobalLogger.LogLevel.VERBOSE:
			return show_verbose

	return false


# ============================================================
# Reload Snapshot
#
# Forces the debug panel to reload the current filtered log view.
#
# This is used by:
# - Refresh button
# - Filter changes
# ============================================================

func _reload_log_snapshot() -> void:
	loading_log_progressively = false
	debug_log_has_loaded_once = false
	debug_log_dirty = true

	pending_live_log_lines.clear()
	pending_log_lines.clear()
	displayed_log_lines.clear()

	display_trim_dirty = false
	display_trim_timer = 0.0

	debug_log_refresh_timer = debug_log_refresh_interval


# ============================================================
# Console Visibility
# ============================================================

func _is_debug_console_visible() -> bool:
	if not is_instance_valid(debug_log_view):
		return false

	return debug_log_view.visible


# ============================================================
# Toggle Debug Console
# ============================================================

func _on_LogToggle_toggled(button_pressed: bool) -> void:
	if is_instance_valid(debug_log_view):
		debug_log_view.visible = button_pressed

	if is_instance_valid(debug_log_backdrop):
		debug_log_backdrop.visible = button_pressed

	if is_instance_valid(log_filter_controls):
		log_filter_controls.visible = button_pressed

	if button_pressed:
		if refresh_snapshot_when_opened:
			debug_log_dirty = true
			debug_log_has_loaded_once = false
			pending_live_log_lines.clear()
			debug_log_refresh_timer = 0.0
	else:
		loading_log_progressively = false
		debug_log_has_loaded_once = false
		pending_live_log_lines.clear()


# ============================================================
# Button Callbacks
# ============================================================

func _on_RefreshLogsButton_pressed() -> void:
	_reload_log_snapshot()


func _on_ShowAllButton_toggled(button_pressed: bool) -> void:
	show_all_logs = button_pressed
	_refresh_filter_button_labels()
	_reload_log_snapshot()


func _on_LiveButton_toggled(button_pressed: bool) -> void:
	live_log_display = button_pressed
	_refresh_filter_button_labels()


func _on_ErrorsButton_toggled(button_pressed: bool) -> void:
	show_errors = button_pressed
	_refresh_filter_button_labels()
	_reload_log_snapshot()


func _on_WarningsButton_toggled(button_pressed: bool) -> void:
	show_warnings = button_pressed
	_refresh_filter_button_labels()
	_reload_log_snapshot()


func _on_SystemButton_toggled(button_pressed: bool) -> void:
	show_system = button_pressed
	_refresh_filter_button_labels()
	_reload_log_snapshot()


func _on_InfoButton_toggled(button_pressed: bool) -> void:
	show_info = button_pressed
	_refresh_filter_button_labels()
	_reload_log_snapshot()


func _on_VerboseButton_toggled(button_pressed: bool) -> void:
	show_verbose = button_pressed
	_refresh_filter_button_labels()
	_reload_log_snapshot()
