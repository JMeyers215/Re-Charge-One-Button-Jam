extends Sprite2D

var v_speed : int = 1
var h_speed : int = 1
var up : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	v_speed = randi_range(5,10)
	h_speed = randi_range(10,15)
	var up_check = randi_range(0,1)
	if up_check == 1:
		up = true
	elif up_check == 0:
		up = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.y < 650:
		up = false
	elif global_position.y > 736:
		up = true
	
	if up == false:
		translate(Vector2(-h_speed * delta,v_speed * delta))
	elif up == true:
		translate(Vector2(-h_speed * delta,-v_speed * delta))
	if global_position.x < -200:
		global_position.x = 1450
