@tool
@icon("res://icons/tank_icon.tres")
extends Node2D
class_name Player

@export var bullet_scene:PackedScene

@export var shot_angle: float = -45:
	set(value):
		shot_angle = value
		shot_velocity = degrees_to_vector2(shot_angle, shot_speed)

@export_range(0, 400) var shot_speed: int = 350:
	set(value):
		shot_speed = value
		shot_velocity = degrees_to_vector2(shot_angle, shot_speed)

var shot_velocity:Vector2:
	set(value):
		shot_velocity = value
		queue_redraw()
		
@export var shot_gravity:Vector2:
	set(value):
		shot_gravity = value
		queue_redraw()

@export_range(0,100) var max_shots:int = 3 :
	set(value):
		max_shots = value
		queue_redraw()

func _ready() -> void:
	shot_velocity = degrees_to_vector2(shot_angle, shot_speed)
	
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
	#if not Engine.is_editor_hint():
		#return
	draw_string(ThemeDB.get_default_theme().default_font,Vector2(-40,20),
				str("max shots: ",max_shots),HORIZONTAL_ALIGNMENT_LEFT)
	
	var zero_degrees := 0
	var fourtyfive_degrees := -45
	
	draw_bullet_path(degrees_to_vector2(zero_degrees, shot_speed), Color.CYAN)
	draw_bullet_path(degrees_to_vector2(fourtyfive_degrees, shot_speed), Color.YELLOW)
	
func draw_bullet_path(velocity: Vector2, color: Color) -> void:
	var cannon_position = %CannonPivot.position
	var start_pos = cannon_position
	var points := PackedVector2Array([start_pos])
	var pos = start_pos
	var dt := 0.05
	
	var vel := velocity
	
	for i in 120:
		vel += shot_gravity * dt
		pos += vel * dt
		points.append(pos)
		if pos.y > 800 or pos.x > 1200:
			break
	
	for i in points.size() - 1:
		draw_dashed_line(points[i], points[i + 1], color, -1.0, 5.0)

func degrees_to_vector2(angle_deg: float, speed: float) -> Vector2:
	var angle_rad = deg_to_rad(angle_deg)
	return Vector2(cos(angle_rad), sin(angle_rad)) * speed
