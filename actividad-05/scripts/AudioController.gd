extends Node2D
class_name AudioController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.frog_position_changed.connect(_on_frog_position_changed)
	Settings.bgm_enabled_changed.connect(_change_bgm_enabled)
	Settings.sfx_enabled_changed.connect(_change_sfx_enabled)

	_change_sfx_enabled(Settings.sfx_enabled)   # apply initial state
	_change_bgm_enabled(Settings.bgm_enabled)

func _change_sfx_enabled(enabled: bool) -> void:
	%SFX.volume_db = 0.0 if enabled else -80.0

func _change_bgm_enabled(enabled: bool) -> void:
	%BGM.stream_paused = not enabled

func _on_frog_position_changed(_new_frog_position: Vector2) -> void:
	%SFX.play()
