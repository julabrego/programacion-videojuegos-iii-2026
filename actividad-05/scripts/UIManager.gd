extends Node
class_name UIManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	GameState.score_changed.connect(update_score_text)
	GameState.frog_position_changed.connect(update_frog_position_text)
	
	%SFXButton.button_pressed = Settings.sfx_enabled
	%BGMButton.button_pressed = Settings.bgm_enabled

func update_score_text(score: int):
	print(score)
	%Score.set_text("%s" % score)

func update_frog_position_text(new_position: Vector2):
	%Position.set_text("X: %0.2f, Y: %0.2f" % [new_position.x, new_position.y])
