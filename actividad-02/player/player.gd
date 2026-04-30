extends CharacterBody2D

@export var max_speed = 200.0
@export var acceleration = 600.0
@export var deceleration = 500.0

var facing_direction: Vector2 = Vector2(1.0, 0.0)

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_bottom")
	
	if direction != Vector2.ZERO:
		facing_direction = direction
		var target_velocity = direction * max_speed
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("fire"):
		var bullet = preload("res://bullet/bullet.tscn").instantiate()
		bullet.direction = facing_direction
		bullet.position = position
		
		$"..".add_child(bullet)
