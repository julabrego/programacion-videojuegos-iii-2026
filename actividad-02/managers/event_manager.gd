extends Node
signal lost_game
signal won_game

func restart_level():
	get_tree().reload_current_scene()
