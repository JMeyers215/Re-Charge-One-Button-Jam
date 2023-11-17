extends RigidBody2D

class_name Bullet

@export var bullet_speed : int = 1
@export var bullet_size : int = 1
@export var bullet_damage : int = 1

func _ready() -> void:
	$Sprite2D.scale = Vector2(bullet_size, bullet_size)
	$CollisionShape2D.scale =  Vector2(bullet_size, bullet_size)

func _process(delta: float) -> void:
	translate(Vector2(bullet_speed * delta,0))
	if global_position. x > 1280:
		queue_free()
