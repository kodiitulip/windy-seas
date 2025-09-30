shader_type spatial;

uniform sampler2D DEPTH_TEXTURE : hint_depth_texture;
uniform float beer_factor = 0.8;
uniform vec4 depth_gradient_shallow : source_color;
uniform vec4 depth_gradient_deep : source_color;
uniform float depth_max_distance : hint_range(0.0, 1.0, 0.1) = 1.0;
uniform float depth_factor = 1.0;
uniform float wave_peak_treshold = 2.8;

uniform vec3 waves[3];
uniform vec2 waves_dir[3];
uniform float height_scale = 1.0;

varying vec3 v_normal;
varying float wave_height;

vec4 alphaBlend(vec4 top, vec4 bottom) {
	vec3 color = (top.rgb * top.a) + (bottom.rgb * (1.0 - bottom.a));
	float alpha = top.a + bottom.a * (1.0 - top.a);
	return vec4(color, alpha);
}

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

void computeGerstnerNormal(in vec3 wave, in vec2 wavedir, in vec3 pos,
		float time, inout vec3 tangent, inout vec3 binormal) {
	//float amplitude = wave.x;
	float steepness = wave.y;
	float wavelength = wave.z;
	float k = 2.0 * PI / wavelength;
	float c = sqrt(9.8 / k);
	vec2 d = normalize(wavedir);
	float f = k * (dot(d, pos.xz) - c * time);
	//float a = steepness / k;
	tangent += normalize(vec3(1.0 - d.x * d.x * steepness * sin(f),
			d.x * steepness * cos(f), - d.x * d.y * steepness * sin(f)));
	binormal += normalize(vec3(-d.x * d.y * steepness * sin(f),
			d.y * steepness * cos(f), 1.0 - d.y * d.y * steepness * sin(f)));
}

void vertex() {
	vec3 original_p = (MODEL_MATRIX * vec4(VERTEX.xyz, 1.0)).xyz;
	vec3 displacement = vec3(0.0);
	vec3 tangent = vec3(1.0, 0.0, 0.0);
	vec3 binormal = vec3(0.0, 0.0, 1.0);
	for (int i = 0; i < waves.length(); i++) {
		displacement += gerstnerWave(waves[i], waves_dir[i], original_p, TIME / 2.0);
		computeGerstnerNormal(waves[i], waves_dir[i], original_p, TIME / 2.0,
				tangent, binormal);
	}
	VERTEX.y += height_scale * displacement.y;
	vec3 normal = normalize(cross(binormal, tangent));
	v_normal = normal;
	wave_height = VERTEX.y;
}

void fragment() {
	float depth_val = texture(DEPTH_TEXTURE, SCREEN_UV).r;
	float depth = PROJECTION_MATRIX[3][2] / (depth_val + PROJECTION_MATRIX[2][2]);
	depth = depth + VERTEX.z;
	depth = exp(-depth * beer_factor);
	depth = 1.0 - depth;
	
	float water_depth = clamp(depth / depth_max_distance, 0.0, 1.0) * depth_factor;
	vec4 water_color = mix(depth_gradient_shallow, depth_gradient_deep, water_depth);
	vec4 color = alphaBlend(water_color, water_color);
	NORMAL = v_normal;
	float wave_peak = clamp((wave_height - wave_peak_treshold) * 2.0, 0.0, 4.0); 
	vec3 peak_color = mix(color.rgb, vec3(1.0), wave_peak);
	
	ALBEDO = peak_color;
	EMISSION = peak_color / 2.0;
	ALPHA = color.a;
	ROUGHNESS = 0.1;
	CLEARCOAT = 1.0;
	CLEARCOAT_ROUGHNESS = 0.0;
	METALLIC = 0.5;
}