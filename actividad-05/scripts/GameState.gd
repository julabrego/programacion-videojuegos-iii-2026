extends Node

signal score_changed(score: int)
signal frog_position_changed(frog_position: Vector2)

var score: int = 0
var frog_position: Vector2 = Vector2.ZERO

func add_score(amount: int = 1) -> void:
	score += amount
	score_changed.emit(score)

func set_frog_position(new_position: Vector2) -> void:
	if frog_position.is_equal_approx(new_position):
		return
	frog_position = new_position
	frog_position_changed.emit(frog_position)
