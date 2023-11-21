extends Node2D

var healthbar : TextureProgressBar

func _ready() -> void:
	$HealAnimation.play()

func _physics_process(delta: float) -> void:
	translate(Vector2(-50 * delta,0))

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		$HealNoise.play()
		healthbar = get_node("../UIController/healthbar")
		healthbar.value = 4
		queue_free()
