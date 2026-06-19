@tool
@icon("res://icons/tank_icon.tres")
extends Node2D
class_name Player

@export var bullet_scene:PackedScene

@export var shot_velocity:Vector2
@export var shot_gravity:Vector2

@export_range(0,100) var max_shots:int = 3 :
	set(value):
		max_shots = value
		queue_redraw()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if Input.is_action_just_pressed(&"ui_accept"):
		var bullet:Bullet = bullet_scene.instantiate()
		bullet.shot_gravity = shot_gravity
		bullet.shot_velocity = shot_velocity
		bullet.position = %CannonPivot.global_position
		
		var container_node = self
		if has_node("%BulletContainer"):
			container_node = %BulletContainer
		container_node.add_child(bullet)
		

func _draw() -> void:
	if not Engine.is_editor_hint():
		return
	draw_string(ThemeDB.get_default_theme().default_font,Vector2(-40,20),
				str("max shots: ",max_shots),HORIZONTAL_ALIGNMENT_LEFT)
	
