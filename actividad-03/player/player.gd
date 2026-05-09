extends CharacterBody2D

@export var SPEED: float = 160
@export var MAX_HEALTH: float = 100

@onready var health = MAX_HEALTH

var dead = false

signal health_change
signal im_dead

var current_movement: int = 0
# 0 = Mouse
# 1 = Tap
# 2 = Teclado (polling)
# 3 = Telcado (eventos)

func _ready():
	emit_signal("health_change",health)

func _physics_process(delta):
	match current_movement:
		0:
			handle_follow_mouse_movement(delta)
		1:
			pass
		2:
			pass
		3:
			pass
	
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

func handle_action_polling_movement(delta):
	var motion = Input.get_vector("move_left","move_right","move_up","move_bottom")
	
	velocity = motion.normalized()*SPEED
	move_and_slide()

func handle_follow_mouse_movement(delta):
	var mouse_position = get_global_mouse_position()
	var distance = mouse_position.distance_to(position)
	
	if distance > 5:
		var direction = (mouse_position - position).normalized()
		velocity = (direction * SPEED)
		move_and_slide()

func _on_option_button_item_selected(index: int) -> void:
	current_movement = index
