@tool
@icon("res://icons/tank_icon.tres")
extends Node2D
class_name Player

const MIN_CANNON_ANGLE = -45
const MAX_CANNON_ANGLE = 0
const MIN_SHOT_SPEED = 100
const MAX_SHOT_SPEED = 350

@export var bullet_scene:PackedScene

@export_range(MIN_CANNON_ANGLE, MAX_CANNON_ANGLE) var shot_angle: int = MIN_CANNON_ANGLE:
	set(value):
		shot_angle = value
		shot_velocity = degrees_to_vector2(shot_angle, shot_speed)

@export_range(MIN_SHOT_SPEED, MAX_SHOT_SPEED) var shot_speed: int = MAX_SHOT_SPEED:
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
	%CannonPivot.rotation = deg_to_rad(shot_angle)
	
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if Input.is_action_pressed(&'ui_up'):
		shot_angle -= 1
		%CannonPivot.rotation = deg_to_rad(shot_angle)
	elif Input.is_action_pressed(&'ui_down'):
		shot_angle += 1
		%CannonPivot.rotation = deg_to_rad(shot_angle)
	shot_angle = clamp(shot_angle, MIN_CANNON_ANGLE, MAX_CANNON_ANGLE)
		
	if Input.is_action_just_pressed(&"ui_accept"):
		if has_node("%BulletContainer"):
			var bullets_in_scene = %BulletContainer.get_child_count()
			if bullets_in_scene < max_shots:
				var bullet:Bullet = bullet_scene.instantiate()
				bullet.shot_gravity = shot_gravity
				bullet.shot_velocity = shot_velocity
				bullet.position = %CannonPivot.global_position
				
				var container_node = self
				container_node = %BulletContainer
				container_node.add_child(bullet)
		
func _draw() -> void:
	if not Engine.is_editor_hint():
		return
	draw_string(ThemeDB.get_default_theme().default_font,Vector2(-40,20),
				str("max shots: ",max_shots),HORIZONTAL_ALIGNMENT_LEFT)

	draw_bullet_path(degrees_to_vector2(MIN_CANNON_ANGLE, shot_speed), Color.CYAN)
	draw_bullet_path(degrees_to_vector2(MAX_CANNON_ANGLE, shot_speed), Color.YELLOW)
	
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
