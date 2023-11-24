extends Node2D

@export var ship_sprite : Sprite2D
@export var enemy_speed : int = 25    
@export var fire_rate : float = 1
@export var alpha_bullet_scene : PackedScene
@export var health : int = 2
@export var point_load : int = 1
@export var alpha_explosion : PackedScene
var fire_ready : bool = false
var mainscene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	$Bullet.wait_time = randi_range(4,8)
	$Bullet.wait_time /= fire_rate
	mainscene = get_node("/root/Main")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mainscene.paused == false:
		translate(Vector2(-enemy_speed * delta,0))
	
	if mainscene.paused == true:
		$Bullet.paused = true
	elif mainscene.paused == false:
		$Bullet.paused = false
	
	if global_position.x < 1300:
		fire_ready = true
	
	if global_position.x < -100:
		queue_free()
		var wave_manager = get_node("/root/Main/WaveManager")
		wave_manager.enemies_defeated()


func _on_bullet_timeout() -> void:
	if fire_ready == true:
		var enemy_bullet = alpha_bullet_scene.instantiate()
		var enemy_bullet_two = alpha_bullet_scene.instantiate()
		fire_bullet(enemy_bullet, enemy_bullet_two)


func fire_bullet(enemy_bullet, enemy_bullet_two):
	var gun = get_node("Gun")
	add_child(enemy_bullet)
	enemy_bullet.position += Vector2(-15,0)
	enemy_bullet.bullet_speed = -enemy_bullet.bullet_speed
	var gun_two = get_node("Gun2")
	add_child(enemy_bullet_two)
	enemy_bullet_two.position += Vector2(-15,0)
	$EnemyShot.play()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		$EnemyHit.play()
		var bullet_damage = area.bullet_damage
		area.bullet_reduce(health)
		if bullet_damage > 0:
			health -= bullet_damage
		if health <= 0:
			destroy_enemy()

func destroy_enemy():
	$DeathTimer.start()
	$EnemyDestroyed.play()
	var explosion_scene = alpha_explosion.instantiate()
	get_parent().add_child(explosion_scene)
	explosion_scene.global_position = global_position
	$".".visible = false

func _on_death_timer_timeout() -> void:
	mainscene.spawn_power_up(global_position)
	queue_free()
	var wave_manager = get_node("/root/Main/WaveManager")
	wave_manager.enemies_defeated()
