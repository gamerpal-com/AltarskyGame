// ============================================================
// SkyGradient Shader
//
// Creates ALTARSKY's atmospheric sky gradient.
//
// Responsibilities:
// - Upper atmosphere coloration
// - Mid atmosphere coloration
// - Horizon glow
// - Dynamic day/night color transitions
//
// Parameters are controlled at runtime by
// SkyCycleController.gd.
//
// Future Expansion:
// - Atmospheric haze
// - Dithering
// - Weather effects
// - Celestial events
// ============================================================

shader_type canvas_item;

// Upper atmosphere color.
uniform vec4 top_color : source_color = vec4(0.05, 0.08, 0.18, 1.0);

// Mid-atmosphere color.
uniform vec4 middle_color : source_color = vec4(0.30, 0.20, 0.40, 1.0);

// Horizon glow color.
uniform vec4 horizon_color : source_color = vec4(0.95, 0.45, 0.25, 1.0);

// Lower atmosphere color.
uniform vec4 bottom_color : source_color = vec4(1.0, 0.70, 0.40, 1.0);

// Vertical position of the horizon glow.
// 0.0 = top of screen
// 1.0 = bottom of screen
uniform float horizon_position = 0.72;

// Controls how broad or concentrated the glow appears.
uniform float horizon_strength = 1.35;

void fragment() {
	// Current vertical position within the gradient.
	float y = UV.y;

	// Blend between top and middle atmosphere colors.
	float upper_t = smoothstep(0.0, horizon_position, y);
	vec4 upper_gradient = mix(top_color, middle_color, upper_t);

	// Blend between horizon and lower atmosphere colors.
	float lower_t = smoothstep(horizon_position, 1.0, y);
	vec4 lower_gradient = mix(horizon_color, bottom_color, lower_t);

	// Controls how smoothly the upper and lower gradients merge.
	float horizon_blend = smoothstep(
		horizon_position - 0.18,
		horizon_position + 0.18,
		y
	);

	vec4 final_color = mix(
		upper_gradient,
		lower_gradient,
		horizon_blend
	);

	// Creates the atmospheric glow around the horizon.
	float horizon_glow = 1.0 - abs(y - horizon_position);
	horizon_glow = pow(
		clamp(horizon_glow, 0.0, 1.0),
		horizon_strength
	);

	// Add a subtle glow contribution.
	final_color.rgb += horizon_color.rgb * horizon_glow * 0.08;

	COLOR = final_color;
}