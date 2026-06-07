extends Node

signal score_changed(score: int)
signal frog_position_changed(frog_position: Vector2)
signal persisted_data_changed(is_data_available: bool, data: String)
signal error_message_triggered(error_message: String)

var score: int = 0
var frog_position: Vector2 = Vector2.ZERO

func add_score(amount: int = 1) -> void:
	score += amount
	score_changed.emit(score)
	
func set_score(value: int) -> void:
	score = value
	score_changed.emit(score)

func set_frog_position(new_position: Vector2) -> void:
	if frog_position.is_equal_approx(new_position):
		return
	frog_position = new_position
	frog_position_changed.emit(frog_position)
