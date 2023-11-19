extends Node2D

@export var movingcloud : PackedScene
var cloud_count : Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cloud_count = get_tree().get_nodes_in_group("Cloud")

func _on_cloud_timer_timeout() -> void:
	if cloud_count.size() < 10:
		var movingcloud = movingcloud.instantiate()
		add_child(movingcloud)
		var side = randi_range(-1,1)
		if side < 0:
			side = "Left"
		elif side >= 0:
			side = "Right"
		
		if side == "Right":
			movingcloud.position = Vector2(1700, randi_range(0,720))
			movingcloud.speed = -movingcloud.speed
		elif side == "Left":
			movingcloud.position = Vector2(-500, randi_range(0,720))
