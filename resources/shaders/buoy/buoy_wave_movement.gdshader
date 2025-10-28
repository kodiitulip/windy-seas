shader_type spatial;

uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_nearest_mipmap, repeat_enable;

uniform vec3 waves[3];
uniform vec2 waves_dir[3];
uniform float height_scale = 1.0;
uniform vec3 worldpos = vec3(0.0);

vec3 gerstnerWave(vec3 wave, vec2 wavedir, vec3 pos, float time) {
	float amplitude = wave.x;
	float steepness = wave.y;
	float wavelength = wave.z;
	float k = 2.0 * PI / wavelength;
	float c = sqrt(9.8 / k);
	vec2 d = normalize(wavedir);
	float f = k * (dot(d, pos.xz) - c * time);
	float a = steepness / k;
	return vec3(d.x * a * cos(f), amplitude * a * sin(f), d.y * a * cos(f));
}

void vertex() {
	vec3 displacement = vec3(0.0);
	for (int i = 0; i < waves.length(); i++) {
		displacement -= gerstnerWave(waves[i], waves_dir[i], VERTEX, TIME / 2.0);
	}
	VERTEX.y += height_scale * displacement.y;
}

void fragment() {
	vec4 albedo_tex = texture(texture_albedo, UV);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
}
