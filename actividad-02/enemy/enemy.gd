extends AnimatableBody2D

@export var speed: float = 2.0 
@export var radius: float = 50.0

var angle: float = 0.0
var center_position: Vector2

func _ready():
	center_position = position

func _physics_process(delta):
	angle += speed * delta
	
	var offset = Vector2(cos(angle), sin(angle)) * radius
	
	position = center_position + offset
