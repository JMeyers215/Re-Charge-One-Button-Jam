extends RigidBody2D

class_name Bullet

@export var bullet_speed : int = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	transform.x += Vector2(bullet_speed,0)
