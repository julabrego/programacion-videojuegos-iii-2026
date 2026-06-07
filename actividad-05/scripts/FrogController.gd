extends Sprite2D
class_name FrogController

func _ready():
	pass
	
func _on_game_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.get_button_index() == MouseButton.MOUSE_BUTTON_LEFT:
		var new_position = get_parent().to_local(event.global_position)
		position = new_position

		GameState.set_frog_position(new_position)
		GameState.add_score(1)
