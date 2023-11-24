extends Node2D

class_name Boss

@export var enemy_speed : int = 25    
@export var fire_rate : float = 1
@export var enemy_bullet_scene : PackedScene
@export var health : int = 1
@export var explosion : PackedScene
var fire_ready : bool = false
var ship_up : bool = false
var dying : bool = false
var mainscene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Bullet.wait_time /= fire_rate
	mainscene = get_node("/root/Main")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.x > 1050 && mainscene.paused == false:
		translate(Vector2(-enemy_speed * delta,0))
	elif global_position.x <= 1050 && dying == false:
		fire_ready = true
	
	move_ship()
	if ship_up == true && mainscene.paused == false && global_position.x <= 1050 && dying == false:
		position.y -= enemy_speed * delta
	elif ship_up == false && mainscene.paused == false && global_position.x <= 1050 && dying == false:
		position.y += enemy_speed * delta

func move_ship():
	if position.y >= 600:
		ship_up = true
	elif position.y <= 150:
		ship_up = false

func _on_bullet_timeout() -> void:
	if fire_ready == true && mainscene.paused == false && dying == false:
		var enemy_bullet = enemy_bullet_scene.instantiate()
		var enemy_bullet_two = enemy_bullet_scene.instantiate()
		fire_bullet(enemy_bullet, enemy_bullet_two)
		print("enemy shoot")

func fire_bullet(enemy_bullet, enemy_bullet_two):
	var gun = get_node("Gun")
	get_parent().add_child(enemy_bullet)
	enemy_bullet.global_position += global_position + Vector2(-15,-80)
	enemy_bullet.scale = Vector2(1.5,1.5)
	var gun_two = get_node("Gun2")
	get_parent().add_child(enemy_bullet_two)
	enemy_bullet_two.global_position += global_position + Vector2(-15,80)
	enemy_bullet_two.scale = Vector2(1.5,1.5)
	$EnemyShot.play()
	print("enemy bullet")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		$EnemyHit.play()
		var bullet_damage = area.bullet_damage
		health -= bullet_damage
		if health <= 0:
			destroy_boss()
		print("enemy hit")

func destroy_boss():
	dying = true
	$Propellant.visible = false
	$DestructionTimer.start()
	$ExplosionTimer.start()
	if $DestructionTimer.time_left == 2:
		$EnemyDestroyed.play()
		$EvilShip.visible = false
		$Propellant.visible = false

func _on_destruction_timer_timeout() -> void:
	var explosion_scene = explosion.instantiate()
	get_parent().add_child(explosion_scene)
	explosion_scene.global_position = global_position
	explosion_scene.scale = Vector2(8,8)
	queue_free()

func _on_explosion_timer_timeout() -> void:
	var explosion_scene = explosion.instantiate()
	add_child(explosion_scene)
	explosion_scene.global_position = global_position + Vector2(randi_range(-50,50),randi_range(-80,80))
	$EnemyDestroyed.play()
