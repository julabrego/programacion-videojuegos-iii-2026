extends Control

func _on_health_change(amount):
	$VBoxContainer/health.text = str(amount).pad_decimals(2)


func _on_player_im_dead():
	$VBoxContainer/health.text = "DEAD"
