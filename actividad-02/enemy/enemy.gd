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
	var collision = move_and_collide(motion)
	
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("player") and collider.has_method("get_hurt"):
			collider.get_hurt()

	position = target_position

func get_hurt():
	queue_free()
