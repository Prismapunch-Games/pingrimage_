shader_type spatial;
render_mode cull_disabled;

uniform vec3 sphere_color: source_color = vec3(1.0);
uniform vec3 fresnel_color: source_color = vec3(0.0, 0.7, 0.9);
uniform float alpha = 1.0;

vec3 fresnel_glow(float amount, float intensity, vec3 color, vec3 normal, vec3 view)
{
	return pow((1.0 - dot(normalize(normal), normalize(view))), amount) * color * intensity;
}

void fragment()
{
	vec4 model_position = inverse(MODEL_MATRIX) * INV_VIEW_MATRIX * vec4(VERTEX, 1);
	if(model_position.y - 0.05 > 0.0 || model_position.y + 0.05 < 0.0) {
		discard;
	}
	
	vec3 fresnel = fresnel_glow(4.0, 4.5, fresnel_color, NORMAL, VIEW);
	ALBEDO = vec3(1) + fresnel;
	ALPHA = (fresnel.r + fresnel.g + fresnel.b) / 3.0 * alpha;
}
