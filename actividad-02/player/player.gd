extends CharacterBody2D

@export var max_speed = 200.0
@export var acceleration = 600.0
@export var deceleration = 500.0
@export var push_force = 10.0

var push_velocity
var facing_direction: Vector2 = Vector2(1.0, 0.0)

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_bottom")
	
	if direction != Vector2.ZERO:
		facing_direction = direction
		var target_velocity = direction * max_speed
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody2D:
			var rb_direction = -collision.get_normal()
		
			if velocity.dot(rb_direction) > 0:
				collider.apply_central_force(rb_direction * push_force * 100)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("fire"):
		var bullet = preload("res://bullet/bullet.tscn").instantiate()
		bullet.direction = facing_direction
		bullet.position = position
		
		$"..".add_child(bullet)
