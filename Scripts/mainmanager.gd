extends Node2D

var pause_hold : bool = false
var pause_counter : int = 1
var paused : bool = false

func _input(event):
	if Input.is_action_pressed("one_button") && paused == false:
		pause_counter += 1
		print("pausing")
		if pause_counter == 20:
			paused = true
			$Squid.tentacle_counter.paused = true
	elif Input.is_action_just_released("one_button") && paused == false:
		pause_counter = 1
		print("stopped pausing")

func _physics_process(delta):
	pass
