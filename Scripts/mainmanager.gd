extends Node2D

var unpause_counter : int = 1
var pause_counter : int = 1
@export var paused : bool = false

func _input(event):
	if Input.is_action_pressed("one_button") && paused == false:
		pause_counter += 1
		if pause_counter == 30:
			paused = true
			$Squid.tentacle_counter.paused = true
	elif Input.is_action_just_released("one_button") && paused == false:
		pause_counter = 1

	if Input.is_action_pressed("one_button") && paused == true:
		unpause_counter += 1
		if unpause_counter == 50:
			paused = false
			$Squid.tentacle_counter.paused = false
	elif Input.is_action_just_released("one_button") && paused == true:
		unpause_counter = 1

func _physics_process(delta):
	pass

