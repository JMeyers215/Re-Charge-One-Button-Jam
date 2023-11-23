extends Area2D

var laser_stage : int = 1
@export var health : int = 5

func _ready() -> void:
	$ChargeAnimation.animation = "ChargeUp"

func _process(delta: float) -> void:
	if health == 0:
		laser_stage = 1
		health = 5
		$ChargeTimer.stop()
		$ChargeAnimation.visible = false
		$".".visible = false

func charge_laser():
	$ChargeAnimation.visible = true
	$ChargeAnimation.start()

func fire_laser():
	$LaserProjectile.visible = true
	$LaserProjectile/LaserTimer.start()

func _on_laser_timer_timeout() -> void:
	$LaserProjectile.visible = false
	laser_stage = 1

func _on_charge_animation_animation_finished() -> void:
	laser_stage = 2
	$ChargeAnimation.animation = "ChargeLoop"
	$ChargeTimer.start()

func _on_charge_timer_timeout() -> void:
	if laser_stage == 3:
		fire_laser()
	laser_stage = 3
	$ChargeAnimation.animation = "FinalCharge"
	$ChargeTimer.start()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		var bullet_damage = area.bullet_damage
		health -= bullet_damage
