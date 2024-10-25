shader_type canvas_item;

uniform float alpha = 0.5;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float a = color.a;
	if (a != 0.0) {
		color.a = alpha;
	}
	COLOR = color;
}
