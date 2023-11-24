extends Area2D

@export var bullet_speed : int = 1
@export var vertical_speed : int = 1
@export var bullet_size : int = 1
@export var bullet_damage : int = 1
@export var health : int = 1
var mainscene

func _ready() -> void:
	$CollisionShape2D.scale =  Vector2(bullet_size, bullet_size)
	$Sprite2D.scale = Vector2(bullet_size, bullet_size)
	mainscene = get_node("/root/Main")

func _process(delta: float) -> void:
	if mainscene.paused == false:
		translate(Vector2(bullet_speed * delta,vertical_speed * delta))
	if global_position.x > 1500 || global_position.x < -200:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet") or area.is_in_group("Ship"):
		queue_free()
	
