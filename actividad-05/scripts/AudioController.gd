extends Node2D
class_name AudioController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Settings.sfx_enabled_changed.connect(_on_sfx_enabled_changed)
	Settings.bgm_enabled_changed.connect(_on_bgm_enabled_changed)
	
	GameState.frog_position_changed.connect(_on_frog_position_changed)

	_on_sfx_enabled_changed(Settings.sfx_enabled)   # apply initial state
	_on_bgm_enabled_changed(Settings.bgm_enabled)

func _on_sfx_enabled_changed(enabled: bool) -> void:
	%SFX.volume_db = 0.0 if enabled else -80.0

func _on_bgm_enabled_changed(enabled: bool) -> void:
	%BGM.stream_paused = not enabled

func _on_frog_position_changed(new_frog_position: Vector2) -> void:
	%SFX.play()
