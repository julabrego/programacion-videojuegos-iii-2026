extends Node
class_name UIManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%SFXButton.button_pressed = $"..".sfx_enabled
	%BGMButton.button_pressed = $"..".bgm_enabled

func update_score_text(score: int):
	%Score.set_text("%s" % score)

func update_frog_position_text(x: float, y: float):
	%Position.set_text("X: %0.2f, Y: %0.2f" % [x, y])
