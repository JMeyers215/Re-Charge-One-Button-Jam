extends Node2D

class_name Ship
var charge_count : int = 1
@export var small_bullet_scene : PackedScene 
@export var big_bullet_scene : PackedScene
@export var perf_small_bullet_scene : PackedScene
@export var perf_big_bullet_scene : PackedScene
@export var ship_speed : float = 1.0
var ship_up : bool = false
var main : Node
var paused : bool = false
var perf_texture : Texture = preload("res://Assets/UI Assets/ProgressBarOverPerfect.png")
var normal_texture : Texture = preload("res://Assets/UI Assets/ProgressBarOver.png")

func _ready() -> void:
	$AnimatedSprite2D.play()
	main = get_node("/root/Main")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("one_button") && main.paused == false:
		charge_count += 1
		if charge_count > 50:
			charge_count = 50
	move_ship()
	$ChargeBar.value = charge_count
	if ship_up == true && main.paused == false:
		position.y -= ship_speed
	elif ship_up == false && main.paused == false:
		position.y += ship_speed
	
	if charge_count == 23:
		$PerfectSmall.start()
	elif charge_count == 48:
		$PerfectLarge.start()
		
	if $PerfectSmall.time_left > 0 || $PerfectLarge.time_left > 0 :
		$ChargeBar.texture_over = perf_texture

func move_ship():
	if position.y >= 600:
		ship_up = true
	elif position.y <= 50:
		ship_up = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("one_button"):
		if charge_count == 50 && $PerfectLarge.time_left == 0:
			var big_b = big_bullet_scene.instantiate()
			fire_big_bullet(big_b)
			charge_count = 0
		elif charge_count < 50 && charge_count > 25:
			var small_b = small_bullet_scene.instantiate()
			fire_small_bullet(small_b)
			charge_count = 0
		elif $PerfectSmall.time_left>0:
			var perf_small = perf_small_bullet_scene.instantiate()
			fire_perfect_small(perf_small)
			charge_count = 0
		elif $PerfectLarge.time_left>0:
			var perf_big = perf_big_bullet_scene.instantiate()
			fire_perfect_big(perf_big)
			charge_count = 0
		else:
			charge_count = 0
		

func fire_big_bullet(big_b):
	owner.add_child(big_b)
	big_b.position = $".".global_position + Vector2(50,0)
	print("big shot")

func fire_small_bullet(small_b):
	owner.add_child(small_b)
	small_b.position = $".".global_position + Vector2(50,0)
	print("small shot")

func fire_perfect_small(perf_small):
	owner.add_child(perf_small)
	perf_small.position = $".".global_position + Vector2(50,0)
	print("perfect small")

func fire_perfect_big(perf_big):
	owner.add_child(perf_big)
	perf_big.position = $".".global_position + Vector2(50,0)
	print("perfect big")

func _on_perfect_large_timeout() -> void:
	$ChargeBar.texture_over = normal_texture

func _on_perfect_small_timeout() -> void:
	$ChargeBar.texture_over = normal_texture
