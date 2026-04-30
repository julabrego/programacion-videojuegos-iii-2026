extends AnimatableBody2D

@export var speed: float = 2.0 
@export var radius: float = 50.0

var angle: float = 0.0
var center_position: Vector2

func _ready():
	center_position = position

func _physics_process(delta):
	angle += speed * delta
	var target_position = center_position + Vector2(cos(angle), sin(angle)) * radius
	
	var motion = target_position - position
	move_and_collide(motion)

	position = target_position

func get_damage():
	queue_free()
