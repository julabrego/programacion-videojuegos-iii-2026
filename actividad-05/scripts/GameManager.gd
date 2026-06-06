extends Node
class_name GameManager

var sfx_enabled : bool = true
var bgm_enabled : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_sfx_button_toggled(toggled_on: bool) -> void:
	sfx_enabled = toggled_on
	%SFX.process_mode = Node.PROCESS_MODE_DISABLED

func _on_bgm_button_toggled(toggled_on: bool) -> void:
	bgm_enabled = toggled_on
	%BGM.playing = toggled_on
