extends Node
class_name FrogController

var frog_position: Vector2
var score: int = 0

func _ready():
	%BGM.set_autoplay($"..".bgm_enabled)

func _on_game_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.get_button_index() == MouseButton.MOUSE_BUTTON_LEFT:
		frog_position = event.global_position
		score += 1
		
		%FrogIdle.position = frog_position
		
		%UIManager.update_score_text(score)
		%UIManager.update_frog_position_text(frog_position.x, frog_position.y)
		
		if Settings.sfx_enabled:
			%SFX.play()
