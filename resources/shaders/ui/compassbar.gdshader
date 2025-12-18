shader_type canvas_item;

global uniform float compass_direction = 0.0;


void fragment() {
	vec2 uv = vec2(UV.x + compass_direction / TAU, UV.y);
	COLOR = texture(TEXTURE, uv);
}