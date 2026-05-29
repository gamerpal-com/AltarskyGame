shader_type canvas_item;

uniform vec4 top_color : source_color = vec4(0.05, 0.08, 0.18, 1.0);
uniform vec4 middle_color : source_color = vec4(0.30, 0.20, 0.40, 1.0);
uniform vec4 horizon_color : source_color = vec4(0.95, 0.45, 0.25, 1.0);
uniform vec4 bottom_color : source_color = vec4(1.0, 0.70, 0.40, 1.0);

uniform float horizon_position = 0.72;
uniform float horizon_strength = 1.35;

void fragment() {
	float y = UV.y;

	float upper_t = smoothstep(0.0, horizon_position, y);
	vec4 upper_gradient = mix(top_color, middle_color, upper_t);

	float lower_t = smoothstep(horizon_position, 1.0, y);
	vec4 lower_gradient = mix(horizon_color, bottom_color, lower_t);

	float horizon_blend = smoothstep(horizon_position - 0.18, horizon_position + 0.18, y);

	vec4 final_color = mix(upper_gradient, lower_gradient, horizon_blend);

	float horizon_glow = 1.0 - abs(y - horizon_position);
	horizon_glow = pow(clamp(horizon_glow, 0.0, 1.0), horizon_strength);

	final_color.rgb += horizon_color.rgb * horizon_glow * 0.08;

	COLOR = final_color;
}