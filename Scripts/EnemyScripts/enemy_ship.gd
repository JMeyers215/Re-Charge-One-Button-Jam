class_name Enemy

extends Node2D

@export var enemy_speed : int = 25    
@export var fire_rate : float = 1
@export var enemy_bullet_scene : PackedScene
@export var health : int = 1
var fire_ready : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()
	$Bullet.wait_time /= fire_rate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.y < 600:
		translate(Vector2(-enemy_speed * delta,0))
	if global_position.x < 1300:
		fire_ready = true
	if global_position.x < 50:
		queue_free()
	
	if fire_ready == true:
		$Bullet.start()

func _on_bullet_timeout() -> void:
	var enemy_bullet = enemy_bullet_scene.instantiate()
	fire_bullet(enemy_bullet)
	print("enemy shoot")

func fire_bullet(enemy_bullet):
	add_child(enemy_bullet)
	enemy_bullet.position += Vector2(-15,0)
	$EnemyShot.play()
	print("enemy bullet")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		$EnemyHit.play()
		print("enemy hit")
