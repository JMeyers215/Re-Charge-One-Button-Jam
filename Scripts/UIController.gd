extends Control

var select_counter : int = 1
var id_select : int = 1
var main : Node

func _ready() -> void:
	main = get_node("/root/Main")

func _physics_process(delta: float) -> void:
	if main.paused == true:
		hover(id_select)
	
	if Input.is_action_pressed("one_button") && main.paused == true:
		select_counter += 1

	if select_counter == 30 && id_select == 1:
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	elif select_counter == 30 && id_select == 2:
		get_tree().quit()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("one_button") && main.paused == true:
		select_counter = 0
		if id_select == 1:
			id_select = 2
		elif id_select == 2:
			id_select = 1

func hover(id_select):
	if id_select == 1:
		$PausePanel/QuitHover.visible = true
		$PausePanel/ExitHover.visible = false
	elif id_select == 2:
		$PausePanel/ExitHover.visible = true
		$PausePanel/QuitHover.visible = false
