extends Node2D
class_name PersistenceManager

const SAVE_PATH = "user://save.json"

func _ready():
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		GameState.persisted_data_changed.emit(false)
		return
	
	var json := JSON.new()
	var error = json.parse(file.get_line())
	if error != OK:
		GameState.persisted_data_changed.emit(false)
		return
	
	var save_dict = json.get_data()
	if save_dict is Dictionary and save_dict.has("game"):
		var has_data = true
		GameState.persisted_data_changed.emit(has_data, JSON.stringify(save_dict, "  "))
	else:
		GameState.persisted_data_changed.emit(false)

func save_game_v0_1() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	var frog_position = GameState.frog_position
	var score = GameState.score
	var bgm_enabled = Settings.bgm_enabled
	var save_dict = {
		version = "0.1",
		game = {
			frog_position = var_to_str(frog_position),
			score = var_to_str(score)
		},
		configuration = {
			bgm_enabled = bgm_enabled
		}
	}
	
	file.store_line(JSON.stringify(save_dict))
	GameState.persisted_data_changed.emit(true,  JSON.stringify(save_dict, "  "))

func load_game_v0_1():
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary
	
	var version = str_to_var(save_dict.version)
	if version > 0.1:
		GameState.error_message_triggered.emit("Versión no compatible")
		return

	var frog_position = str_to_var(save_dict.game.frog_position)
	var score = str_to_var(save_dict.game.score)
	var bgm_enabled = save_dict.configuration.bgm_enabled
	
	GameState.set_frog_position(frog_position)
	GameState.set_score(score)
	Settings.set_bgm_enabled(bgm_enabled)

func save_game_v0_3() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	var frog_position = GameState.frog_position
	var score = GameState.score
	var bgm_enabled = Settings.bgm_enabled
	var sfx_enabled = Settings.sfx_enabled
	
	var save_dict = {
		version = "0.3",
		game = {
			frog_position = var_to_str(frog_position),
			score = var_to_str(score)
		},
		configuration = {
			bgm_enabled = bgm_enabled,
			sfx_enabled = sfx_enabled
		}
	}
	
	file.store_line(JSON.stringify(save_dict))
	GameState.persisted_data_changed.emit(true, JSON.stringify(save_dict, "  "))

func load_game_v0_3():
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary

	var frog_position = str_to_var(save_dict.game.frog_position)
	var score = str_to_var(save_dict.game.score)
	var bgm_enabled = save_dict.configuration.bgm_enabled
	var sfx_enabled = save_dict.configuration.sfx_enabled if save_dict.configuration.has("sfx_enabled") else Settings.sfx_enabled
	
	GameState.set_frog_position(frog_position)
	GameState.set_score(score)
	Settings.set_bgm_enabled(bgm_enabled)
	Settings.set_sfx_enabled(sfx_enabled)
	
func clear_data() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_line("{}")
	GameState.persisted_data_changed.emit(false)
