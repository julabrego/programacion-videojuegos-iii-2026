shader_type canvas_item;

uniform vec3 ORIGINAL_LIGHT_COLOR : source_color = vec3(0.0, 1.0, 1.0);
uniform vec3 ORIGINAL_DARK_COLOR : source_color = vec3(0.0, 0.451, 0.969);

uniform float THRESHOLD = 0.3;

uniform vec3 MODIFIED_LIGHTBLUE: source_color = vec3(0.0, 1.0, 1.0);
uniform vec3 MODIFIED_BLUE: source_color = vec3(0.0, 0.451, 0.969);

void fragment() {
    vec4 texture_color = texture(TEXTURE, UV);
    vec3 current_color = texture_color.rgb;

    float light_color_distance = length(current_color - ORIGINAL_LIGHT_COLOR);
    float dark_color_distance = length(current_color - ORIGINAL_DARK_COLOR);

    float light_color_factor = step(light_color_distance, THRESHOLD);
    float dark_color_factor = step(dark_color_distance, THRESHOLD);

    vec3 modified_color = mix(current_color, MODIFIED_LIGHTBLUE, light_color_factor);
    modified_color = mix(modified_color, MODIFIED_BLUE, dark_color_factor);

    COLOR = vec4(modified_color, texture_color.a);
}
