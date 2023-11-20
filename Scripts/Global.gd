extends Node

@onready var global_vars = get_node("/root/Global")

#options variables
var music_option : float = 0.5
var sound_option : float = 0.5
var keybind : String = "Space"

#score variables
var high_score : int = 0

#defines the save path
const SAVE_PATH = "user://Re-Charge.json"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var json = JSON.new()
	if FileAccess.file_exists(SAVE_PATH):
		load_game()
	else:
		save_game()

func save_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	var global = get_node("/root/Global")
	
	var save_dict = {
		global = {
			high_score = int(high_score),
			music_option = float(music_option),
			sound_option = float(sound_option),
			keybind = str(keybind)
		}
	}
	
	file.store_line(JSON.stringify(save_dict))
	file.close()

func load_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()    

	json.parse(file.get_line()) 

	var save_dict : Dictionary = json.get_data()
	var global := get_node("/root/Global") as Global
	global.high_score = int(save_dict.global.high_score)
	global.keybind = str(save_dict.global.keybind)
	global.music_option = float(save_dict.global.music_option)
	global.sound_option = float(save_dict.global.sound_option)
	file.close()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
		get_tree().quit()
