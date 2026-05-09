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

var keyboard_action_poll = {
	up = false,
	down = false,
	left = false,
	right = false
}

var target_position: Vector2 = position
var is_moving: bool = false

func _ready():
	emit_signal("health_change",health)

func _physics_process(delta):
	match current_movement:
		0, 1:
			handle_target_follow_movement()
		2:
			handle_keyboard_polling_movement(delta)
		3:
			apply_keyboard_movement(delta)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if current_movement == 0:
			target_position = get_global_mouse_position()
		elif current_movement == 1 and event is InputEventMouseButton and event.is_pressed():
			target_position = get_global_mouse_position()
	elif event is InputEventKey and current_movement == 3:
		if event.is_pressed() or event.is_released():
			var key = event.as_text_keycode().to_lower()
			if ["up", "down", "left", "right"].has(key):
				keyboard_action_poll.set(key, event.is_pressed())
	
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

func handle_keyboard_polling_movement(delta):
	keyboard_action_poll.assign({
		up = Input.is_key_label_pressed(KEY_UP),
		down = Input.is_key_label_pressed(KEY_DOWN),
		left = Input.is_key_label_pressed(KEY_LEFT),
		right = Input.is_key_label_pressed(KEY_RIGHT),
	})
	
	apply_keyboard_movement(delta)
	
func apply_keyboard_movement(delta):
	var motion = Vector2.ZERO
	
	motion.x = int(keyboard_action_poll.right) - int(keyboard_action_poll.left)
	motion.y = int(keyboard_action_poll.down) - int(keyboard_action_poll.up)
	
	if motion.length() > 0:
		motion = motion.normalized()
	
	velocity = motion * SPEED * delta
	move_and_collide(velocity)

func handle_target_follow_movement():
	var distance = target_position.distance_to(position)
	
	if distance > 5:
		is_moving = true
		var direction = (target_position - position).normalized()
		velocity = (direction * SPEED)
		move_and_slide()
	else:
		is_moving = false

func _on_option_button_item_selected(index: int) -> void:
	target_position = position
	is_moving = false
	current_movement = index
