
extends CharacterBody2D

const MOTION_SPEED = 160 # Pixels/second

func _physics_process(delta):
	var motion = Vector2()
	
	if (Input.is_action_pressed("move_up")):
		motion = Vector2(0, -1)
	elif (Input.is_action_pressed("move_bottom")):
		motion = Vector2(0, 1)
	elif (Input.is_action_pressed("move_left")):
		motion = Vector2(-1, 0)
	elif (Input.is_action_pressed("move_right")):
		motion = Vector2(1, 0)
	
	motion = motion.normalized()*MOTION_SPEED*delta
	move_and_collide(motion)

