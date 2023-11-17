extends CharacterBody2D

class_name Tentacle

@export var tentacle_id : int
@export var extended : bool = false
@export var slap : bool = false
@onready var slaptimer : Timer = get_node("SlapExtension")

func _physics_process(delta):
	if slap == true:
		$SmallTentacle.visible = false
		$LargeTentacle.visible = true
		$LargeCollision.visible = true
	elif slap == false:
		$SmallTentacle.visible = true
		$LargeTentacle.visible = false
		$LargeCollision.visible = false
	
	if extended == true:
		$MediumTentacle.visible = true
		$SmallTentacle.visible = false
	elif extended == false:
		$MediumTentacle.visible = false
		$SmallTentacle.visible = true

func _on_slap_extension_timeout():
	slap = false

