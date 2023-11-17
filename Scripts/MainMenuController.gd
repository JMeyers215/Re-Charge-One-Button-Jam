extends Control

var select_counter : int = 1
var id_select : int = 1

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("one_button"):
		id_select += 1
		select_counter = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("one_button"):
		select_counter += 1
	
	if select_counter == 30 && id_select == 1:
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
	elif select_counter == 30 && id_select == 2:
		#options go here
		pass
	elif select_counter == 30 && id_select == 3:
		get_tree().quit()
	
	
	if id_select == 4:
		id_select = 1
	
	if id_select == 1:
		$Buttons/PlayHover.visible = true
		$Buttons/OptionsHover.visible = false
		$Buttons/ExitHover.visible = false
	elif id_select == 2:
		$Buttons/PlayHover.visible = false
		$Buttons/OptionsHover.visible = true
		$Buttons/ExitHover.visible = false
	elif id_select == 3:
		$Buttons/PlayHover.visible = false
		$Buttons/OptionsHover.visible = false
		$Buttons/ExitHover.visible = true



