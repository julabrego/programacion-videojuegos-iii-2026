extends Node2D
class_name PersistenceManager

const SAVE_PATH = "user://save.json"

func _ready():
	var has_data := FileAccess.file_exists(SAVE_PATH) and FileAccess.open(SAVE_PATH, FileAccess.READ).get_length() > 0
	print("has data: %s" % has_data)
	GameState.persisted_data_changed.emit(has_data)

func save_game_v0_1() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	var frog_position = GameState.frog_position
	var score = GameState.score
	var bgm_enabled = Settings.bgm_enabled
	print("save bgm %s" % bgm_enabled)
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
	GameState.persisted_data_changed.emit(true)

	#get_node(^"../LoadJSON").disabled = false

func load_game_v0_1():
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary

	var frog_position = str_to_var(save_dict.game.frog_position)
	var score = str_to_var(save_dict.game.score)
	var bgm_enabled = save_dict.configuration.bgm_enabled
	
	GameState.set_frog_position(frog_position)
	GameState.set_score(score)
	Settings.set_bgm_enabled(bgm_enabled)
	
func clear_data() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_line("")
	GameState.persisted_data_changed.emit(false)
