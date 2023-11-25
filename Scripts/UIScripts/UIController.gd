extends Control

var select_counter : int = 1
var id_select : int = 1
var main : Node

func _ready() -> void:
	main = get_node("/root/Main")

func _physics_process(_delta: float) -> void:
	if main.paused == true || main.game_win == true || main.game_over == true:
		hover(id_select)
	
	if Input.is_action_pressed("one_button") && (main.paused == true || main.game_win == true || main.game_over == true):
		select_counter += 1
		$PausePanel/QuitBar.value = select_counter
		$PausePanel/ExitBar.value = select_counter
		$WinPanel/QuitBar.value = select_counter
		$WinPanel/ExitBar.value = select_counter
		$DeathPanel/QuitBar.value = select_counter
		$DeathPanel/ExitBar.value = select_counter

	if select_counter == 30 && id_select == 1:
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	elif select_counter == 30 && id_select == 2:
		get_tree().quit()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("one_button") && (main.paused == true || main.game_win == true || main.game_over == true):
		select_counter = 0
		$PausePanel/QuitBar.value = 0
		$PausePanel/ExitBar.value = 0
		$WinPanel/QuitBar.value = 0
		$WinPanel/ExitBar.value = 0
		$DeathPanel/QuitBar.value = 0
		$DeathPanel/ExitBar.value = 0
		
		if id_select == 1:
			id_select = 2
			print(id_select)
		elif id_select == 2:
			id_select = 1
			print(id_select)

func hover(id_select):
	if id_select == 1 && main.paused:
		$PausePanel/QuitHover.visible = true
		$PausePanel/ExitHover.visible = false
		$PausePanel/QuitBar.visible = true
		$PausePanel/ExitBar.visible = false
	elif id_select == 2  && main.paused:
		$PausePanel/ExitHover.visible = true
		$PausePanel/QuitHover.visible = false
		$PausePanel/QuitBar.visible = false
		$PausePanel/ExitBar.visible = true
	elif id_select == 1 && main.game_win:
		$WinPanel/QuitHover.visible = true
		$WinPanel/ExitHover.visible = false
		$WinPanel/QuitBar.visible = true
		$WinPanel/ExitBar.visible = false
	elif id_select == 2 && main.game_win:
		$WinPanel/QuitHover.visible = false
		$WinPanel/ExitHover.visible = true
		$WinPanel/QuitBar.visible = false
		$WinPanel/ExitBar.visible = true
	elif id_select == 1 && main.game_over:
		$DeathPanel/QuitHover.visible = true
		$DeathPanel/ExitHover.visible = false
		$DeathPanel/QuitBar.visible = true
		$DeathPanel/ExitBar.visible = false
	elif id_select == 2 && main.game_over:
		$DeathPanel/QuitHover.visible = false
		$DeathPanel/ExitHover.visible = true
		$DeathPanel/QuitBar.visible = false
		$DeathPanel/ExitBar.visible = true
