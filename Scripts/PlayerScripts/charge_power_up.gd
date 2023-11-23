extends Node2D

var mainscene

func _ready() -> void:
	$ChargeAnimation.play()
	mainscene = get_node("/root/Main")

func _physics_process(delta: float) -> void:
	if mainscene.paused == false:
		translate(Vector2(-25 * delta,0))
	if global_position.x < -50:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		var ship_node = get_tree().get_first_node_in_group("Ship")
		ship_node.power_up()
		queue_free()
