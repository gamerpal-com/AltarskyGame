extends Node

signal log_appended(line: Dictionary)


# ============================================================
# GlobalLogger
#
# Project-wide logger.
#
# This script stores recent debug messages so the in-game
# DebugPanel can display them.
#
# Important:
# This logger should stay cheap.
#
# It only:
# - Builds a log dictionary.
# - Stores it in a capped list.
# - Optionally prints it to Godot's console.
# - Optionally tells the DebugPanel a new log exists.
#
# Expensive visual work belongs to DebugPanel, not here.
# ============================================================


# ============================================================
# Log Levels
#
# Each log has an importance level.
#
# DebugPanel can use these levels to decide what should be
# visible in-game.
#
# ERROR:
# Something is broken.
#
# WARNING:
# Something may be wrong.
#
# SYSTEM:
# Important game/system event.
#
# INFO:
# Normal debug information.
#
# VERBOSE:
# Very detailed noisy debug information.
# Hidden by default.
# ============================================================

enum LogLevel {
	ERROR,
	WARNING,
	SYSTEM,
	INFO,
	VERBOSE
}


# Maximum number of log entries stored in memory.
#
# When this limit is exceeded, the oldest entries are removed.
const MAX_LINES := 200


# If true, logs also print to Godot's Output panel.
@export var print_to_godot_console := true

# If true, DebugPanel is notified when a new log is added.
#
# This signal should stay cheap on the DebugPanel side.
@export var emit_ui_signal := true


# Stored log history.
#
# Each entry is a Dictionary with:
# - time
# - message
# - level
# - text
var _lines: Array[Dictionary] = []


# ============================================================
# Legacy Log Function
#
# Keep this as ONE argument so old code still works:
#
# GlobalLogger.log("message")
#
# This defaults to INFO.
#
# For leveled logs, prefer:
#
# GlobalLogger.error("message")
# GlobalLogger.warning("message")
# GlobalLogger.system("message")
# GlobalLogger.info("message")
# GlobalLogger.verbose("message")
# ============================================================

func log(msg: String) -> void:
	log_level(msg, LogLevel.INFO)


# ============================================================
# Core Log Function
#
# Creates and stores one log entry.
#
# This is the only place that directly writes to _lines.
# ============================================================

func log_level(msg: String, level: int) -> void:
	var time_string := Time.get_time_string_from_system()
	var level_name := _get_level_name(level)

	var line: Dictionary = {
		"time": time_string,
		"message": msg,
		"level": level,
		"text": "%s | %s | %s" % [
			time_string,
			level_name,
			msg
		]
	}

	_lines.append(line)

	_trim_stored_lines()

	if print_to_godot_console:
		print(str(line["text"]))

	if emit_ui_signal:
		log_appended.emit(line)


# ============================================================
# Level Helper Functions
#
# These make code easier to read.
#
# Example:
# GlobalLogger.error("Missing player node")
# is clearer than:
# GlobalLogger.log_level("Missing player node", GlobalLogger.LogLevel.ERROR)
# ============================================================

func error(msg: String) -> void:
	log_level(msg, LogLevel.ERROR)


func warning(msg: String) -> void:
	log_level(msg, LogLevel.WARNING)


func system(msg: String) -> void:
	log_level(msg, LogLevel.SYSTEM)


func info(msg: String) -> void:
	log_level(msg, LogLevel.INFO)


func verbose(msg: String) -> void:
	log_level(msg, LogLevel.VERBOSE)


# ============================================================
# Text Access
#
# These functions convert stored logs into plain text.
#
# DebugPanel mostly uses filtered recent lines now, but these are
# still useful for quick debugging or future tools.
# ============================================================

func get_all_text() -> String:
	var text_lines := PackedStringArray()

	for line in _lines:
		text_lines.append(str(line["text"]))

	return "\n".join(text_lines)


func get_recent_text(max_lines: int = 50) -> String:
	var recent_lines := get_recent_lines(max_lines)
	var text_lines := PackedStringArray()

	for line in recent_lines:
		text_lines.append(str(line["text"]))

	return "\n".join(text_lines)


# ============================================================
# Raw Line Access
#
# Returns recent log dictionaries instead of plain text.
#
# DebugPanel uses these dictionaries so it can filter by level.
# ============================================================

func get_recent_lines(max_lines: int = 50) -> Array[Dictionary]:
	var start_index: int = max(0, _lines.size() - max_lines)
	var recent_lines: Array[Dictionary] = []

	for i in range(start_index, _lines.size()):
		recent_lines.append(_lines[i])

	return recent_lines


func get_filtered_recent_lines(
	max_lines: int,
	show_errors: bool,
	show_warnings: bool,
	show_system: bool,
	show_info: bool,
	show_verbose: bool,
	show_all: bool
) -> Array[Dictionary]:
	var filtered_lines: Array[Dictionary] = []

	for line in _lines:
		var level := int(line["level"])

		if show_all or _should_show_level(
			level,
			show_errors,
			show_warnings,
			show_system,
			show_info,
			show_verbose
		):
			filtered_lines.append(line)

	var start_index: int = max(0, filtered_lines.size() - max_lines)
	var recent_lines: Array[Dictionary] = []

	for i in range(start_index, filtered_lines.size()):
		recent_lines.append(filtered_lines[i])

	return recent_lines


# ============================================================
# Clear Log History
#
# Clears stored logs.
#
# After clearing, sends a small SYSTEM log so DebugPanel knows
# the display should refresh.
# ============================================================

func clear() -> void:
	_lines.clear()

	var line: Dictionary = {
		"time": Time.get_time_string_from_system(),
		"message": "Log history cleared.",
		"level": LogLevel.SYSTEM,
		"text": "%s | SYSTEM | Log history cleared." % Time.get_time_string_from_system()
	}

	if emit_ui_signal:
		log_appended.emit(line)


func get_line_count() -> int:
	return _lines.size()


# ============================================================
# Internal Helpers
# ============================================================

func _trim_stored_lines() -> void:
	while _lines.size() > MAX_LINES:
		_lines.remove_at(0)


func _should_show_level(
	level: int,
	show_errors: bool,
	show_warnings: bool,
	show_system: bool,
	show_info: bool,
	show_verbose: bool
) -> bool:
	match level:
		LogLevel.ERROR:
			return show_errors
		LogLevel.WARNING:
			return show_warnings
		LogLevel.SYSTEM:
			return show_system
		LogLevel.INFO:
			return show_info
		LogLevel.VERBOSE:
			return show_verbose

	return false


func _get_level_name(level: int) -> String:
	match level:
		LogLevel.ERROR:
			return "ERROR"
		LogLevel.WARNING:
			return "WARNING"
		LogLevel.SYSTEM:
			return "SYSTEM"
		LogLevel.INFO:
			return "INFO"
		LogLevel.VERBOSE:
			return "VERBOSE"

	return "UNKNOWN"
