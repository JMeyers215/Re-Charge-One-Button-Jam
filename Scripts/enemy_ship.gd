extends Node2D

var enemy_speed : int = 1
var fire_rate : float = 1
@export var enemy_bullet_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_bullet_timeout() -> void:
	var enemy_bullet = enemy_bullet_scene.instantiate()
	fire_bullet(enemy_bullet)
	print("enemy shoot")

func fire_bullet(enemy_bullet):
	add_child(enemy_bullet)
	enemy_bullet.position += Vector2(-15,0)
	print("enemy bullet")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		print("enemy hit")
