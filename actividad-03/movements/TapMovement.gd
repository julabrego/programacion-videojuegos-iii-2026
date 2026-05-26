extends Node

var target_node: Node
@export var SPEED: float = 160
@export var MOUSE_DISTANCE_TRESHOLD = 5

var target_position: Vector2
var is_moving: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_node = get_parent()
	while target_node and not target_node is CharacterBody2D:
			target_node = target_node.get_parent()
	activate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	apply_move_to_target()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		target_position = target_node.get_global_mouse_position()

func activate():
	target_position = target_node.position
	
func apply_move_to_target():
	var distance = target_position.distance_to(target_node.position)
	
	if distance > MOUSE_DISTANCE_TRESHOLD:
		is_moving = true
		var direction = (target_position - target_node.position).normalized()
		target_node.velocity = (direction * SPEED)
		target_node.move_and_slide()
	else:
		is_moving = false
