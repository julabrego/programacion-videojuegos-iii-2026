extends Node

signal sfx_enabled_changed(enabled: bool)
signal bgm_enabled_changed(enabled: bool)

var sfx_enabled : bool = true
var bgm_enabled : bool = true

func toggle_sfx() -> void:
	sfx_enabled = not sfx_enabled
	sfx_enabled_changed.emit(sfx_enabled)

func toggle_bgm() -> void:
	bgm_enabled = not bgm_enabled
	bgm_enabled_changed.emit(bgm_enabled)

func set_bgm_enabled(enabled: bool) -> void:
	bgm_enabled = enabled
	bgm_enabled_changed.emit(bgm_enabled)
	
func set_sfx_enabled(enabled: bool) -> void:
	sfx_enabled = enabled
	sfx_enabled_changed.emit(sfx_enabled)
