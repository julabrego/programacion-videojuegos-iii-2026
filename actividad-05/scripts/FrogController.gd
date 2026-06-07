extends Node2D
class_name FrogController

func _ready():
	pass

func _on_game_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.get_button_index() == MouseButton.MOUSE_BUTTON_LEFT:
		var local_position = event.position
		var global_position = get_global_transform().affine_inverse() * event.global_position
		%FrogIdle.position = global_position

		GameState.set_frog_position(local_position)
		GameState.add_score(1)
