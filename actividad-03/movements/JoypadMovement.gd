extends Node

var target_node: CharacterBody2D 
@export var SPEED: float = 160

func _ready() -> void:
	target_node = get_parent()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_gamepad_movement()

func handle_gamepad_movement():
	var motion_x = Input.get_axis("move_left", "move_right")
	var motion_y = Input.get_axis("move_up", "move_bottom")
	
	target_node.velocity.x = motion_x * SPEED
	target_node.velocity.y = motion_y * SPEED
	
	target_node.move_and_slide()
