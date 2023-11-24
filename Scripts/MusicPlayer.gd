extends AudioStreamPlayer

@onready var music_control = get_node("/root/Music")

func _ready() -> void:
	stream = preload("res://Music/New Worlds (Long Loop).wav")
	autoplay = true
	play()
