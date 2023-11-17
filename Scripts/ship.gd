extends Node2D

class_name Ship
var charge_count : int = 1
@export var small_bullet_scene : PackedScene 
@export var big_bullet_scene : PackedScene
@export var ship_speed : float = 1.0
var ship_up : bool = false

func _ready() -> void:
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("one_button"):
		charge_count += 1
		if charge_count > 50:
			charge_count = 50
	
	move_ship()
	$ChargeBar.value = charge_count
	if ship_up == true:
		position.y -= ship_speed
	elif ship_up == false:
		position.y += ship_speed

func move_ship():
	if position.y >= 600:
		ship_up = true
	elif position.y <= 50:
		ship_up = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("one_button") &&  charge_count == 50:
		var big_b = big_bullet_scene.instantiate()
		fire_big_bullet(big_b)
		charge_count = 0
	elif Input.is_action_just_released("one_button") && charge_count < 50 && charge_count > 25:
		var small_b = small_bullet_scene.instantiate()
		fire_small_bullet(small_b)
		charge_count = 0
	elif Input.is_action_just_released("one_button"):
		charge_count = 0

func fire_big_bullet(big_b):
	owner.add_child(big_b)
	big_b.position = $".".global_position

func fire_small_bullet(small_b):
	owner.add_child(small_b)
	small_b.position = $".".global_position
