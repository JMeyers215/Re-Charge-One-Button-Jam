extends Area2D

var laser_stage : int = 1
@export var health : int = 5

func _process(delta: float) -> void:
	if health == 0:
		laser_stage = 1
		health = 5
		$ChargeTimer.stop()
		$CollisionShape2D.set_deferred("disabled", true)
		$ChargeAnimation.visible = false
		$".".visible = false
		$"../LaserCheck".start()

func charge_laser():
	$ChargeAnimation.visible = true
	$ChargeAnimation.play()

func fire_laser():
	$ChargeTimer.stop()
	$LaserProjectile.visible = true
	$LaserProjectile/LaserTimer.start()
	$LaserProjectile/CollisionShape2D.set_deferred("disabled",false)
	laser_stage = 1

func _on_laser_timer_timeout() -> void:
	$LaserProjectile.visible = false
	$ChargeAnimation.visible = false
	$".".visible = false
	$LaserProjectile/CollisionShape2D.set_deferred("disabled",true)
	laser_stage = 1

func _on_charge_animation_animation_finished() -> void:
	laser_stage = 2
	$ChargeAnimation.animation = "ChargeLoop"
	$ChargeAnimation.play()
	$ChargeTimer.start()

func _on_charge_timer_timeout() -> void:
	$ChargeAnimation.animation = "FinalCharge"
	$ChargeAnimation.play()
	$FinalChargetimer.start() 

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		var bullet_damage = area.bullet_damage
		health -= bullet_damage

func _on_visibility_changed() -> void:
	if $".".visible == true:
		$ChargeAnimation.animation = "ChargeUp"
		$ChargeAnimation.play()
		charge_laser()

func _on_final_chargetimer_timeout() -> void:
	laser_stage = 3
	fire_laser()
