extends Node2D

@export var movingcloud : PackedScene
@export var both_sides : bool = true
var cloud_count : Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var i : int = 0
	while i < 5:
		var movingcloud = movingcloud.instantiate()
		add_child(movingcloud)
		movingcloud.global_position = Vector2(randi_range(0, 1280),randi_range(0,720))
		movingcloud.speed = -movingcloud.speed
		i += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cloud_count = get_tree().get_nodes_in_group("Cloud")

func _on_cloud_timer_timeout() -> void:
	if cloud_count.size() < 10:
		movingcloud = movingcloud.instantiate()
		add_child(movingcloud)
		var side = randi_range(-1,1)
		if both_sides == true:
			if side < 0:
				side = "Left"
			elif side >= 0:
				side = "Right"
		elif both_sides == false:
			side = "Right"
		
		if side == "Right":
			movingcloud.position = Vector2(1600, randi_range(0,720))
			movingcloud.speed = -movingcloud.speed
		elif side == "Left":
			movingcloud.position = Vector2(-400, randi_range(0,720))
