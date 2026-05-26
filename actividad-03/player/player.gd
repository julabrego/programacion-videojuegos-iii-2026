extends CharacterBody2D

@export var SPEED: float = 160
@export var MAX_HEALTH: float = 100

@onready var health = MAX_HEALTH
@onready var movements: Array[Node] = $Movements.get_children()

var dead = false

signal health_change
signal im_dead

var MOUSE_DISTANCE_TRESHOLD = 5

# 0 = Mouse | 1 = Tap | 2 = Teclado (polling) | 3 = Telcado (eventos) | 4 = Joypad (MapInput)
var current_movement: int = 0 

var target_position: Vector2 = position
var is_moving: bool = false
	
func _ready():
	emit_signal("health_change",health)
	toggle_current_movement(current_movement)

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

func toggle_current_movement(index: int) -> void:
	for i in movements.size():
		movements[i].process_mode = Node.PROCESS_MODE_ALWAYS if i == index else Node.PROCESS_MODE_DISABLED
	if movements[index].has_method("activate"):
		movements[index].activate()
	
	#match index:
		#0:
			#$FollowMouseMovement.process_mode = Node.PROCESS_MODE_ALWAYS
			#$TapMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$KeyboardPollingMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$KeyboardEventMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$JoypadMovement.process_mode = Node.PROCESS_MODE_DISABLED
		#1:
			#$FollowMouseMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$TapMovement.process_mode = Node.PROCESS_MODE_ALWAYS
			#$TapMovement.activate()
			#$KeyboardPollingMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$KeyboardEventMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$JoypadMovement.process_mode = Node.PROCESS_MODE_DISABLED
		#2:
			#$FollowMouseMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$TapMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$KeyboardPollingMovement.process_mode = Node.PROCESS_MODE_ALWAYS
			#$KeyboardEventMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$JoypadMovement.process_mode = Node.PROCESS_MODE_DISABLED
		#3:
			#$FollowMouseMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$TapMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$KeyboardPollingMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$KeyboardEventMovement.process_mode = Node.PROCESS_MODE_ALWAYS
			#$JoypadMovement.process_mode = Node.PROCESS_MODE_DISABLED
		#4:
			#$FollowMouseMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$TapMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$KeyboardPollingMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$KeyboardEventMovement.process_mode = Node.PROCESS_MODE_DISABLED
			#$JoypadMovement.process_mode = Node.PROCESS_MODE_ALWAYS
	
func _on_option_button_item_selected(index: int) -> void:
	current_movement = index
	toggle_current_movement(current_movement)
	
