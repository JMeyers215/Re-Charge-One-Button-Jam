extends Area2D

class_name Bullet

@export var bullet_speed : int = 1
@export var bullet_size : int = 1
@export var bullet_damage : int = 1

func _ready() -> void:
	$CollisionShape2D.scale =  Vector2(bullet_size, bullet_size)
	$Sprite2D.scale = Vector2(bullet_size, bullet_size)

func _process(delta: float) -> void:
	translate(Vector2(bullet_speed * delta,0))
	if global_position.x > 1280 || global_position.x < 0:
		queue_free()

func _physics_process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet") || area.is_in_group("Enemy"):
		print("bullet hit")
		queue_free()
