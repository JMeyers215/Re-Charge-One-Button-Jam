extends Node2D

class_name Ship

#charge variables
var charge_count : int = 1
var charge_power_up : bool = false

#bullet scenes
@export var small_bullet_scene : PackedScene 
@export var big_bullet_scene : PackedScene
@export var perf_small_bullet_scene : PackedScene
@export var perf_big_bullet_scene : PackedScene

#movement variables
@export var ship_speed : float = 1.0
var ship_up : bool = false
var dying : bool = false

#UI and Game Handling
@export var healthbar : TextureProgressBar
var main : Node
var paused : bool = false
var perf_texture : Texture = preload("res://Assets/UI Assets/ProgressBarOverPerfect.png")
var normal_texture : Texture = preload("res://Assets/UI Assets/ProgressBarOver.png")

#EXPLOSIONS!!!
@export var explosion : PackedScene

func _ready() -> void:
	$AnimatedSprite2D.play()
	main = get_node("/root/Main")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("one_button") && main.paused == false && dying == false && main.game_win == false:
		if charge_power_up == true:
			charge_count += 3
		else:
			charge_count += 1
	
	if charge_count > 50:
			charge_count = 50
	move_ship()
	
	if ship_up == true && main.paused == false && dying == false && main.game_win == false:
		position.y -= ship_speed * delta
	elif ship_up == false && main.paused == false && dying == false && main.game_win == false:
		position.y += ship_speed * delta
	
	if main.game_win == true:
		if global_position.y > 380 && global_position.y != 360:
			global_position.y -= ship_speed * delta
		elif global_position.y < 350 && global_position.y != 360:
			global_position.y += ship_speed * delta
		elif global_position.y < 380 || global_position.y > 350:
			global_position.y = 360
			translate(Vector2(ship_speed * delta,0))
	
	$ChargeBar.value = charge_count
	if charge_count == 23:
		$PerfectSmall.start()
	elif charge_count == 48:
		$PerfectLarge.start()
		
	if $PerfectSmall.time_left > 0 || $PerfectLarge.time_left > 0 :
		$ChargeBar.texture_over = perf_texture
	
	if main.paused == true:
		$PowerUpTimer.paused == true

func move_ship():
	if position.y >= 600:
		ship_up = true
	elif position.y <= 75:
		ship_up = false

func _input(_event: InputEvent) -> void:
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
	big_b.position = $".".global_position + Vector2(75,0)
	$AudioManager/BigShot.play()

func fire_small_bullet(small_b):
	owner.add_child(small_b)
	small_b.position = $".".global_position + Vector2(75,0)
	$AudioManager/SmallShot.play()

func fire_perfect_small(perf_small):
	owner.add_child(perf_small)
	perf_small.position = $".".global_position + Vector2(75,0)
	$AudioManager/PerfSmallShot.play()

func fire_perfect_big(perf_big):
	owner.add_child(perf_big)
	perf_big.position = $".".global_position + Vector2(75,0)
	$AudioManager/PerfBigShot.play()

func _on_perfect_large_timeout() -> void:
	$ChargeBar.texture_over = normal_texture

func _on_perfect_small_timeout() -> void:
	$ChargeBar.texture_over = normal_texture

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("EnemyBullet"):
		$AudioManager/ShipHit.play()
		healthbar.value -= area.bullet_damage
		if healthbar.value <= 0:
			game_over()

func power_up():
	$PowerUpTimer.start()
	charge_power_up = true
	$AudioManager/ChargeNoise.play()

func _on_power_up_timer_timeout() -> void:
	charge_power_up = false

func heal_noise():
	$AudioManager/HealNoise.play()

func game_over():
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$DestroyTimer.start()
	$ExplosionTimer.start()
	dying = true

func _on_explosion_timer_timeout() -> void:
	var explosion_scene = explosion.instantiate()
	get_parent().add_child(explosion_scene)
	explosion_scene.global_position = global_position + Vector2(randi_range(0,45),randi_range(-14,14))
	explosion_scene.scale = Vector2(2,2)
	$AudioManager/ShipDestroyed.play()

func _on_destroy_timer_timeout() -> void:
	main.game_over = true
	queue_free()
