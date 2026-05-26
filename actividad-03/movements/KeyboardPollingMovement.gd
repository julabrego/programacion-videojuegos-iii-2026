extends Node

var target_node: CharacterBody2D
@export var SPEED: float = 160

var keyboard_action_poll = {
	up = false,
	down = false,
	left = false,
	right = false
}

func _ready() -> void:
	target_node = get_parent()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	apply_keyboard_movement(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_pressed() or event.is_released():
			handle_keyboard_event_based_status(event)

func handle_keyboard_event_based_status(event: InputEventKey):
	if event.keycode == KEY_UP:
		keyboard_action_poll.set("up", event.is_pressed())
	if event.keycode == KEY_DOWN:
		keyboard_action_poll.set("down", event.is_pressed())
	if event.keycode == KEY_LEFT:
		keyboard_action_poll.set("left", event.is_pressed())
	if event.keycode == KEY_RIGHT:
		keyboard_action_poll.set("right", event.is_pressed())

func apply_keyboard_movement(delta):
	var motion = Vector2.ZERO
	
	motion.x = int(keyboard_action_poll.right) - int(keyboard_action_poll.left)
	motion.y = int(keyboard_action_poll.down) - int(keyboard_action_poll.up)
	
	if motion.length() > 0:
		motion = motion.normalized()
	
	target_node.velocity = motion * SPEED * delta
	target_node.move_and_collide(target_node.velocity)
