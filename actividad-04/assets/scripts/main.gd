extends Node2D

const color_options = [
	{
		MODIFIED_LIGHTBLUE = Vector3(0.0, 1.0, 1.0),
		MODIFIED_BLUE = Vector3(0.0, 0.451, 0.969),
		MODIFIED_BLACK = Vector3(0.02, 0.02, 0.02)
	},
	{
		MODIFIED_LIGHTBLUE = Vector3(1.0, 1.0, 1.0),
		MODIFIED_BLUE = Vector3(0.733, 0.278, 0.004),
		MODIFIED_BLACK = Vector3(0.02, 0.02, 0.02)
	},
	{
		MODIFIED_LIGHTBLUE = Vector3(1.0, 1.0, 1.0),
		MODIFIED_BLUE = Vector3(0.004, 0.58, 0.004),
		MODIFIED_BLACK = Vector3(0.02, 0.02, 0.02)
	},
	{
		MODIFIED_LIGHTBLUE = Vector3(0.886, 0.741, 0.141),
		MODIFIED_BLUE = Vector3(0.804, 0.141, 0.004),
		MODIFIED_BLACK = Vector3(0.02, 0.02, 0.02)
	},
	{
		MODIFIED_LIGHTBLUE = Vector3(0.929, 0.443, 0.831),
		MODIFIED_BLUE = Vector3(0.788, 0.365, 0.859),
		MODIFIED_BLACK = Vector3(0.02, 0.02, 0.02)
	},
]

var current_option = 0

func _on_button_pressed():
	next_option()
	
func next_option():
	current_option = current_option + 1 if current_option < color_options.size() - 1 else 0
	change_sprite_color(current_option)
	
func change_sprite_color(option: int):
	material.set_shader_parameter("MODIFIED_LIGHTBLUE", color_options[option].MODIFIED_LIGHTBLUE)
	material.set_shader_parameter("MODIFIED_BLUE", color_options[option].MODIFIED_BLUE)
	material.set_shader_parameter("MODIFIED_BLACK", color_options[option].MODIFIED_BLACK)
