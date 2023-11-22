extends Node2D

func _ready() -> void:
	$ChargeAnimation.play()

func _physics_process(delta: float) -> void:
	translate(Vector2(-50 * delta,0))

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		var ship_node = get_tree().get_first_node_in_group("Ship")
		ship_node.power_up()
		queue_free()
