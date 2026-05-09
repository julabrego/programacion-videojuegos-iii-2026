extends CharacterBody2D

@export var SPEED: float = 160
@export var MAX_HEALTH: float = 100

@onready var health = MAX_HEALTH

var dead = false

signal health_change
signal im_dead

func _ready():
	emit_signal("health_change",health)


func _physics_process(delta):
	var motion = Input.get_vector("move_left","move_right","move_up","move_bottom")
	
	velocity = motion.normalized()*SPEED
	
	move_and_slide()

func hurt(amount):
	health = clamp(health-amount, 0 , 100)
	
	#esto podría ir en un setter
	if health <= 0:
		if !dead:
			emit_signal("im_dead")
			dead = true
			set_physics_process(false) 
		health = 0
		return
	
	emit_signal("health_change",health)

