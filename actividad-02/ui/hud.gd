extends Control

var modal_node: Control
var message_node: Label
var button_node: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modal_node = $Modal
	modal_node.visible = false
	modal_node.process_mode = Node.PROCESS_MODE_DISABLED
	message_node = $Modal/VBoxContainer/Label
	button_node = $Modal/VBoxContainer/Button
	
	EventManager.lost_game.connect(handle_game_over)
	EventManager.won_game.connect(handle_win)

func handle_game_over():
	modal_node.process_mode = Node.PROCESS_MODE_ALWAYS
	message_node.text = "Perdiste :("
	button_node.text = "Reintentar"
	
	modal_node.visible = true
	
func handle_win():
	modal_node.process_mode = Node.PROCESS_MODE_ALWAYS
	message_node.text = "¡Ganaste! :D"
	button_node.text = "Jugar de nuevo"
	
	modal_node.visible = true

func _on_button_button_up() -> void:
	EventManager.restart_level()
