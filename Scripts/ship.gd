extends Node2D

class_name Ship
var charge_count : int = 1

func _physics_process(delta: float) -> void:
	move_ship()

func move_ship():
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("one_button"):
		charge_count += 1
		if charge_count > 100:
			charge_count = 100
	
	if Input.is_action_just_released("one_button"):
		fire_bullet()

func fire_bullet():
	if charge_count > 50 && charge_count < 100:
		pass
	elif charge_count == 100:
		pass
