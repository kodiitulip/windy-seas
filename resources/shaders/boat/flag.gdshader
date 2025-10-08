shader_type spatial;
//render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_burley, specular_schlick_ggx;

uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_nearest_mipmap, repeat_enable;

uniform sampler2D uv_offset_texture: hint_default_black;
uniform vec2 uv_offset_scale = vec2(-0.2, -0.1);
uniform float time_scale = 0.3;

void vertex() {
	vec2 base_uv = VERTEX.yz * uv_offset_scale;
	vec2 noise_uv = (base_uv + vec2(TIME,0.0) * time_scale);
	float noise = texture(uv_offset_texture, noise_uv).r;
	noise = (noise - 0.5) * 2.0;
	VERTEX.x += noise * (VERTEX.z);
}

void fragment() {
	vec4 albedo_tex = texture(texture_albedo, UV);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
}
