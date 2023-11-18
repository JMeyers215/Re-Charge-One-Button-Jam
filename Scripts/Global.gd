extends Node

@onready var global_vars = get_node("/root/Global")

#options variables
var music_option : float = 0.5
var sound_option : float = 0.5
var keybind : Key = KEY_SPACE

#score variables
var high_score : int = 0
