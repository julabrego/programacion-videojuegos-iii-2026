extends Node
class_name LevelManager

var frog_position: Vector2
var score: int = 0

func _on_game_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		frog_position = event.global_position
		score += 1
		
		%FrogIdle.position = frog_position
		
		%Score.set_text("%s" % score)
		%Position.set_text("X: %0.2f, Y: %0.2f" % [frog_position.x, frog_position.y])
