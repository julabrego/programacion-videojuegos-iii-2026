@tool
extends EditorPlugin

var dock

func _enter_tree():
	var dock_scene = preload("res://addons/target_spawner/target_spawner_button.tscn").instantiate()

	dock_scene.get_node("Button").plugin = self
	dock = EditorDock.new()
	dock.add_child(dock_scene)

	dock.title = "Scene editor actions"

	dock.default_slot = DOCK_SLOT_RIGHT_UR

	dock.available_layouts = EditorDock.DOCK_LAYOUT_VERTICAL | EditorDock.DOCK_LAYOUT_FLOATING

	add_dock(dock)


func _exit_tree():
	remove_dock(dock)
	dock.queue_free()

const SPAWN_AREA = {
	from = Vector2(573, 16),
	to = Vector2(1135, 540)
}

func spawn_target() -> void:
	var parent = EditorInterface.get_edited_scene_root()
	var target_scene = preload("res://targets/target_01.tscn")
	var target_instance = target_scene.instantiate()
	
	var spawn_x = randi_range(SPAWN_AREA['from'].x, SPAWN_AREA['to'].x)
	var spawn_y = randi_range(SPAWN_AREA['from'].y, SPAWN_AREA['to'].y)
	
	var target_count = 0
	for child in EditorInterface.get_edited_scene_root().get_children():
		if child.name.begins_with("Target"):
			target_count += 1
	target_instance.name = "Target" + str(target_count + 1)

	target_instance.position = Vector2(spawn_x, spawn_y)
	parent.add_child(target_instance)
	target_instance.owner = EditorInterface.get_edited_scene_root()
	
	EditorInterface.mark_scene_as_unsaved()


# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	pass

func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass
