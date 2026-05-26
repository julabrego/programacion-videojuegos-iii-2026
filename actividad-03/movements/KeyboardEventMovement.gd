extends Node

var target_node: Node
@export var SPEED: float = 160

var keyboard_action_poll = {
	up = false,
	down = false,
	left = false,
	right = false
}

func _ready() -> void:
	target_node = get_parent()
	while target_node and not target_node is CharacterBody2D:
			target_node = target_node.get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_keyboard_polling_based_status(delta)
	apply_keyboard_movement(delta)

func handle_keyboard_polling_based_status(delta):
	keyboard_action_poll.assign({
		up = Input.is_key_label_pressed(KEY_UP),
		down = Input.is_key_label_pressed(KEY_DOWN),
		left = Input.is_key_label_pressed(KEY_LEFT),
		right = Input.is_key_label_pressed(KEY_RIGHT),
	})

func apply_keyboard_movement(delta):
	var motion = Vector2.ZERO
	
	motion.x = int(keyboard_action_poll.right) - int(keyboard_action_poll.left)
	motion.y = int(keyboard_action_poll.down) - int(keyboard_action_poll.up)
	
	if motion.length() > 0:
		motion = motion.normalized()
	
	target_node.velocity = motion * SPEED * delta
	target_node.move_and_collide(target_node.velocity)
