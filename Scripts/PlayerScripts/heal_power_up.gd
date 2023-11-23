extends Node2D

var healthbar : TextureProgressBar
var mainscene

func _ready() -> void:
	$HealAnimation.play()
	mainscene = get_node("/root/Main")

func _physics_process(delta: float) -> void:
	if mainscene.paused == false:
		translate(Vector2(-25 * delta,0))
	if global_position.x < -50:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		healthbar = get_node("../UIController/healthbar")
		healthbar.value = 4
		var ship_node = get_tree().get_first_node_in_group("Ship")
		ship_node.heal_noise()
		queue_free()
