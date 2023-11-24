extends Node2D

class_name Boss

@export var enemy_speed : int = 25    
@export var fire_rate : float = 1
@export var enemy_bullet_scene : PackedScene
@export var health : int = 1
@export var explosion : PackedScene
@export var laser : Area2D
@export var drone : PackedScene
var fire_ready : bool = false
var ship_up : bool = false
var dying : bool = false
var charging_laser : bool = false
var mainscene

func _ready() -> void:
	$Bullet.wait_time /= fire_rate
	mainscene = get_node("/root/Main")

func _process(delta: float) -> void:
	if global_position.x > 1050 && mainscene.paused == false:
		translate(Vector2(-enemy_speed * delta,0))
		$Hitbox/CollisionShape2D.set_deferred("disabled", true)
	elif global_position.x <= 1050 && dying == false:
		fire_ready = true
		$Hitbox/CollisionShape2D.set_deferred("disabled", false)
	
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
	if fire_ready == true && mainscene.paused == false && dying == false && charging_laser == false:
		fire_bullet()

func fire_bullet():
	var enemy_bullet = enemy_bullet_scene.instantiate()
	get_parent().add_child(enemy_bullet)
	enemy_bullet.global_position = global_position
	enemy_bullet.global_position += Vector2(-15, -80)
	enemy_bullet.scale = Vector2(1.5,1.5)
	
	var enemy_bullet_two = enemy_bullet_scene.instantiate()
	get_parent().add_child(enemy_bullet_two)
	enemy_bullet_two.global_position = global_position
	enemy_bullet_two.global_position += Vector2(-15, 80)
	enemy_bullet_two.scale = Vector2(1.5,1.5)
	$EnemyShot.play()
	print("fire bullet called")

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
	$Laser.visible = false
	$Laser/LaserProjectile/CollisionShape2D.set_deferred("disabled", true)
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

func _on_laser_check_timeout() -> void:
	if fire_ready == true && dying == false:
		charging_laser = true
		laser.visible = true
		$Laser/CollisionShape2D.set_deferred("disabled", false)
		$LaserCheck.stop()

func _on_laser_timer_timeout() -> void:
	
	$LaserCheck.start()
	print("laser check started")
	charging_laser = false

func _on_drone_timer_timeout() -> void:
	var drone_scene = drone.instantiate()
	get_parent().add_child(drone_scene)
	randomize()
	var top_or_bottom = randi_range(0,1)
	
	if top_or_bottom == 1:
		drone_scene.global_position = Vector2(1250, 600)
	else:
		drone_scene.global_position = Vector2(1250, 150)
