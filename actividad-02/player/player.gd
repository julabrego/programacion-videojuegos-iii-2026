extends CharacterBody2D

@export var max_speed = 200.0
@export var acceleration = 600.0
@export var deceleration = 500.0

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_bottom")
	if direction != Vector2.ZERO:
		var target_velocity = direction * max_speed
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	move_and_slide()
