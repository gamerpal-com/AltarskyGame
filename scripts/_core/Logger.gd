extends Node

signal log_appended(line: String)

const MAX_LINES := 200
var _lines: PackedStringArray = []

func log(msg: String) -> void:
	# Timestamp + message
	var line := "%s | %s" % [Time.get_time_string_from_system(), msg]

	# Store
	_lines.append(line)
	if _lines.size() > MAX_LINES:
		_lines.remove_at(0)

	# Print to normal Godot console (same as in-game)
	print(line)

	# Notify UI that a new line exists
	log_appended.emit(line)

func get_all_text() -> String:
	return "\n".join(_lines)
