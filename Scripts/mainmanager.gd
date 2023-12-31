extends Node2D

var unpause_counter : int = 0
var pause_counter : int = 0
var paused : bool = false
var game_over : bool = false
var game_win : bool = false
@export var health_spawn : PackedScene
@export var power_up : PackedScene
@onready var music = get_node("/root/Music")

func _ready() -> void:
	var new_key
	new_key = Global.keybind
	$CurrentKey/KeyCode.text = str(": ", new_key)
	music = get_node("/root/Music")
	pass

func _input(_event):
	if Input.is_action_just_pressed("one_button") && paused == false:
		pause_counter +=1
		$UIController/PauseCounter/PauseCount.text = str("x ",pause_counter)
		
		$UIController/PauseTimer.start()
	
	if Input.is_action_just_pressed("one_button") && paused == true:
		unpause_counter +=1
		$UIController/PauseCounter/PauseCount.text = str("x ",unpause_counter)
		
		$UIController/PauseTimer.start()

	if pause_counter == 5:
		paused = true
		pause_counter = 0
		$UIController/PauseCounter/PauseSymbol.visible = false
		$UIController/PauseCounter/PlaySymbol.visible = true
	
	if unpause_counter == 5:
		paused = false
		unpause_counter = 0
		$UIController/PauseCounter/PauseSymbol.visible = true
		$UIController/PauseCounter/PlaySymbol.visible = false

func _physics_process(_delta):
	if paused == true:
		$UIController/PausePanel.visible = true
	elif paused == false:
		$UIController/PausePanel.visible = false
	
	if game_win == true:
		$UIController/WinPanel.visible = true
	elif game_win == false:
		$UIController/WinPanel.visible = false
	
	if game_over == true:
		$UIController/DeathPanel.visible = true
	elif game_over == false:
		$UIController/DeathPanel.visible = false

func _on_pause_timer_timeout() -> void:
	pause_counter = 0
	unpause_counter= 0
	if paused == true:
		$UIController/PauseCounter/PauseCount.text = str("x ",unpause_counter)
	elif paused == false:
		$UIController/PauseCounter/PauseCount.text = str("x ",pause_counter)

func spawn_power_up(enemy_pos):
	var item = randi_range(1,100)
	if item <= 15:
		var health = health_spawn.instantiate()
		add_child(health)
		health.global_position = enemy_pos
	elif item <= 25 && item > 15:
		var charge = power_up.instantiate()
		add_child(charge)
		charge.global_position = enemy_pos

func _game_win():
	game_win = true
	print("game won")
	print(game_win)
	music.stream = preload("res://Music/Horizon (Long Loop).wav")
	music.autoplay = true
	music.play()
