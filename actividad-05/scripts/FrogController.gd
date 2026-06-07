extends Sprite2D
class_name FrogController

func _ready():
	GameState.frog_position_changed.connect(_on_frog_position_changed)
	
func _on_game_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.get_button_index() == MouseButton.MOUSE_BUTTON_LEFT:
		var new_position = get_parent().to_local(event.global_position)

		GameState.set_frog_position(new_position)
		GameState.add_score(1)

func _on_frog_position_changed(new_position: Vector2) -> void:
	position = new_position
	
