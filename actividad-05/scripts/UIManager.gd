extends Node
class_name UIManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	GameState.score_changed.connect(update_score_text)
	GameState.frog_position_changed.connect(update_frog_position_text)
	Settings.bgm_enabled_changed.connect(update_bgm_enabled_switch)
	GameState.persisted_data_changed.connect(update_load_persisted_data_status)
	
	%SFXButton.button_pressed = Settings.sfx_enabled
	%BGMButton.button_pressed = Settings.bgm_enabled

func update_score_text(score: int):
	%Score.set_text("%s" % score)

func update_frog_position_text(new_position: Vector2):
	%Position.set_text("X: %0.2f, Y: %0.2f" % [new_position.x, new_position.y])

func update_load_persisted_data_status(is_data_available: bool) -> void:
	print("is data available: %s" % is_data_available)
	%Load01.disabled = not is_data_available
	%Load03.disabled = not is_data_available
	
func update_bgm_enabled_switch(enabled: bool) -> void:
	%BGMButton.button_pressed = enabled

func _on_bgm_button_toggled(toggled_on: bool) -> void:
	Settings.set_bgm_enabled(toggled_on)

func _on_sfx_button_toggled(toggled_on: bool) -> void:
	Settings.set_sfx_enabled(toggled_on)
