@tool
extends EditorScript
class_name EditorSpawnerEditor

const SPAWN_AREA = {
	from = Vector2(1, 1),
	to = Vector2(100, 100)
}

# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	# `parent` could be any node in the scene.
	var parent = get_scene().get_node("Parent")
	var target_scene = preload("res://targets/target_01.tscn")
	var target_instance = target_scene.new()
	
	var spawn_x = randi_range(SPAWN_AREA['from'].x, SPAWN_AREA['to'].x)
	var spawn_y = randi_range(SPAWN_AREA['from'].y, SPAWN_AREA['to'].y)
	
	target_instance.position = Vector2(spawn_x, spawn_y)
	parent.add_child(target_instance)

	# The line below is required to make the node visible in the Scene tree dock
	# and persist changes made by the tool script to the saved scene file.
	target_instance.owner = get_scene()
