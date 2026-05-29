extends Control

@onready var background_color: ColorRect = $BackgroundColor
@onready var gradient_overlay: ColorRect = $GradientOverlay

@export_group("Cycle Durations")
@export var morning_duration := 5.0
@export var day_duration := 5.0
@export var sunset_duration := 5.0
@export var night_duration := 5.0

@export_group("Base Sky Colors")
@export var morning_base := Color("#7FB9FF")
@export var day_base := Color("#3F8CFF")
@export var sunset_base := Color("#5B3A8C")
@export var night_base := Color("#07152F")

@export_group("Gradient Top Colors")
@export var morning_top := Color("#8FCBFF")
@export var day_top := Color("#2F7CFF")
@export var sunset_top := Color("#39245F")
@export var night_top := Color("#061022")

@export_group("Gradient Middle Colors")
@export var morning_middle := Color("#78B8FF")
@export var day_middle := Color("#70C8FF")
@export var sunset_middle := Color("#63406D")
@export var night_middle := Color("#101C3A")

@export_group("Gradient Horizon Colors")
@export var morning_horizon := Color("#FFD6A0")
@export var day_horizon := Color("#D8F7FF")
@export var sunset_horizon := Color("#F08A4B")
@export var night_horizon := Color("#203F7A")

@export_group("Gradient Bottom Colors")
@export var morning_bottom := Color("#FFE8BC")
@export var day_bottom := Color("#BFEFFF")
@export var sunset_bottom := Color("#D77A55")
@export var night_bottom := Color("#1B356B")

@export_group("Gradient Shape")
@export_range(0.0, 1.0) var horizon_position := 0.60
@export_range(0.1, 4.0) var horizon_strength := 1.35

##Player lighting references
@export var player_path: NodePath
@onready var player: Node2D = get_node_or_null(player_path)
var time_in_cycle := 0.0

@export_group("Player Ambient Tint")
@export var morning_player_tint := Color("#FFF2D6")
@export var day_player_tint := Color("#FFFFFF")
@export var sunset_player_tint := Color("#E8A878")
@export var night_player_tint := Color("#7F9BD8")


func _ready() -> void:
	_apply_sky_colors()

func _get_player_tint(t: float) -> Color:
	return _phase_lerp(t, morning_player_tint, day_player_tint, sunset_player_tint, night_player_tint)

func _process(delta: float) -> void:
	var total_duration := _get_total_duration()

	if total_duration <= 0.0:
		return

	time_in_cycle = fmod(time_in_cycle + delta, total_duration)
	_apply_sky_colors()


func _get_total_duration() -> float:
	return morning_duration + day_duration + sunset_duration + night_duration


func _apply_sky_colors() -> void:
	var base_color := _get_base_color(time_in_cycle)
	var top_color := _get_top_color(time_in_cycle)
	var middle_color := _get_middle_color(time_in_cycle)
	var horizon_color := _get_horizon_color(time_in_cycle)
	var bottom_color := _get_bottom_color(time_in_cycle)

	background_color.color = base_color

	var shader_material := gradient_overlay.material as ShaderMaterial
	if shader_material == null:
		return

	shader_material.set_shader_parameter("top_color", top_color)
	shader_material.set_shader_parameter("middle_color", middle_color)
	shader_material.set_shader_parameter("horizon_color", horizon_color)
	shader_material.set_shader_parameter("bottom_color", bottom_color)
	shader_material.set_shader_parameter("horizon_position", horizon_position)
	shader_material.set_shader_parameter("horizon_strength", horizon_strength)

	if player:
		player.modulate = _get_player_tint(time_in_cycle)


func _get_base_color(t: float) -> Color:
	return _phase_lerp(t, morning_base, day_base, sunset_base, night_base)


func _get_top_color(t: float) -> Color:
	return _phase_lerp(t, morning_top, day_top, sunset_top, night_top)


func _get_middle_color(t: float) -> Color:
	return _phase_lerp(t, morning_middle, day_middle, sunset_middle, night_middle)


func _get_horizon_color(t: float) -> Color:
	return _phase_lerp(t, morning_horizon, day_horizon, sunset_horizon, night_horizon)


func _get_bottom_color(t: float) -> Color:
	return _phase_lerp(t, morning_bottom, day_bottom, sunset_bottom, night_bottom)


func _phase_lerp(t: float, morning: Color, day: Color, sunset: Color, night: Color) -> Color:
	var morning_safe: float = maxf(morning_duration, 0.001)
	var day_safe: float = maxf(day_duration, 0.001)
	var sunset_safe: float = maxf(sunset_duration, 0.001)
	var night_safe: float = maxf(night_duration, 0.001)

	var morning_end: float = morning_safe
	var day_end: float = morning_end + day_safe
	var sunset_end: float = day_end + sunset_safe

	if t < morning_end:
		var p_morning: float = t / morning_safe
		p_morning = smoothstep(0.0, 1.0, p_morning)
		return morning.lerp(day, p_morning)

	if t < day_end:
		var p_day: float = (t - morning_end) / day_safe
		p_day = smoothstep(0.0, 1.0, p_day)
		return day.lerp(sunset, p_day)

	if t < sunset_end:
		var p_sunset: float = (t - day_end) / sunset_safe
		p_sunset = smoothstep(0.0, 1.0, p_sunset)
		return sunset.lerp(night, p_sunset)

	var p_night: float = (t - sunset_end) / night_safe
	p_night = smoothstep(0.0, 1.0, p_night)
	return night.lerp(morning, p_night)
