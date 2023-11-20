extends Node2D

@export var drone : Enemy 
@export var elite : Enemy
@export var boss : Enemy
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drone = get_node("EnemyDrone")
	elite = get_node("EnemyElite")
	boss = get_node("EnemyBoss")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
