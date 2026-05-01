extends CharacterBody2D

enum Orientation {
	HORIZONTAL,
	VERTICAL
}

@export var orientation = Orientation.HORIZONTAL
@export var speed = 200
@export var idle_timeout = 2.0

var is_moving = false
var move_direction: Vector2 = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = idle_timeout
	
	if orientation == Orientation.VERTICAL:
		move_direction = Vector2.DOWN
	else:
		move_direction = Vector2.RIGHT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if $Timer.is_stopped() and not is_moving:
		is_moving = true
	
	if is_moving:
		velocity = move_direction * speed
		move_and_slide()
		stop_and_swap_direction()

func stop_and_swap_direction():
	if get_real_velocity().length() < 1.0:
		is_moving = false
		velocity = Vector2.ZERO
		move_direction = -move_direction
		$Timer.start()
	
