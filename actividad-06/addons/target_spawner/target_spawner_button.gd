@tool
extends Button
class_name TargetSpawnerButton

var plugin

func clicked():
	plugin.spawn_target()

func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	pressed.connect(clicked)

func _exit_tree() -> void:
	if pressed.is_connected(clicked):
		pressed.disconnect(clicked)
