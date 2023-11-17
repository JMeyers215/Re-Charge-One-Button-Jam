extends CharacterBody2D

@export var tentacle_id : int
@export var extended : bool = false
@export var slap : bool = false
@onready var slaptimer : Timer = get_node("SlapExtension")

func _physics_process(delta):
	if slap == true:
		$SmallTentacle.visible = false
		$SmallCollision.visible = false
		$LargeTentacle.visible = true
		$LargeCollision.visible = true
	elif slap == false:
		$SmallTentacle.visible = true
		$SmallCollision.visible = true
		$LargeTentacle.visible = false
		$LargeCollision.visible = false
	
	if extended == true:
		$MediumTentacle.visible = true
		$SmallTentacle.visible = false
		$SmallCollision.visible = false
	elif extended == false:
		$MediumTentacle.visible = false
		$SmallTentacle.visible = true
		$SmallCollision.visible = true

func _on_slap_extension_timeout():
	slap = false
