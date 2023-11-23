extends Node2D

class_name Elite

@export var enemy_speed : int = 25    
@export var fire_rate : float = 1
@export var enemy_bullet_scene : PackedScene
@export var health : int = 10
@export var point_load : int = 1
var fire_ready : bool = false
var mainscene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()
	$Bullet.wait_time /= fire_rate
	mainscene = get_node("/root/Main")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.y < 600:
		translate(Vector2(-enemy_speed * delta,0))
	if global_position.x < 1300:
		fire_ready = true
	if global_position.x < 50:
		queue_free()
	
	if mainscene.paused == true:
		$Bullet.paused = true
	elif mainscene.paused == false:
		$Bullet.paused = false

func _on_bullet_timeout() -> void:
	if fire_ready == true:
		var enemy_bullet = enemy_bullet_scene.instantiate()
		var enemy_bullet_two = enemy_bullet_scene.instantiate()
		fire_bullet(enemy_bullet, enemy_bullet_two)
		print("enemy shoot")

func fire_bullet(enemy_bullet, enemy_bullet_two):
	var gun = get_node("Gun")
	add_child(enemy_bullet)
	enemy_bullet.position += Vector2(-15,-10)
	var gun_two = get_node("Gun2")
	add_child(enemy_bullet_two)
	enemy_bullet_two.position += Vector2(-15,10)
	$EnemyShot.play()
	print("enemy bullet")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		$EnemyHit.play()
		var bullet_damage = area.bullet_damage
		health -= bullet_damage
		if health <= 0:
			destroy_enemy()
		print("enemy hit")

func destroy_enemy():
	$DeathTimer.start()
	$EnemyDestroyed.play()
	$".".visible = false

func _on_death_timer_timeout() -> void:
	mainscene.spawn_power_up(global_position)
	var wave_manager = get_node("/root/Main/WaveManager")
	wave_manager.enemies_defeated()
	queue_free()
