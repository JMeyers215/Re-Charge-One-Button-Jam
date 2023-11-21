extends Node2D

var unpause_counter : int = 0
var pause_counter : int = 0
@export var paused : bool = false

func _ready() -> void:
	var new_key
	new_key = Global.keybind
	$CurrentKey/KeyCode.text = str(": ", new_key)
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

func _on_pause_timer_timeout() -> void:
	pause_counter = 0
	unpause_counter= 0
	if paused == true:
		$UIController/PauseCounter/PauseCount.text = str("x ",unpause_counter)
	elif paused == false:
		$UIController/PauseCounter/PauseCount.text = str("x ",pause_counter)
