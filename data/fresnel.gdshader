shader_type spatial;

uniform vec3 sphere_color: source_color = vec3(1.0);
uniform vec3 fresnel_color: source_color = vec3(0.0, 0.7, 0.9);
uniform float alpha = 1.0;

vec3 fresnel_glow(float amount, float intensity, vec3 color, vec3 normal, vec3 view)
{
	return pow((1.0 - dot(normalize(normal), normalize(view))), amount) * color * intensity;
}

void fragment()
{
	vec3 fresnel = fresnel_glow(4.0, 4.5, fresnel_color, NORMAL, VIEW);
	ALBEDO = vec3(1) + fresnel;
	ALPHA = (fresnel.r + fresnel.g + fresnel.b) / 3.0 * alpha;
}
