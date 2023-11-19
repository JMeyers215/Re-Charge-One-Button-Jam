extends Sprite2D

var direction : Vector2
var speed : int = 1
var side : String = "Right"
var size : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	randomize_speed()
	randomize_size()
	scale = Vector2(size, size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	translate(Vector2(speed * delta,0))
	if global_position.x < -600 || global_position.x > 1850:
		queue_free()

func randomize_speed():
	speed = randi_range(10, 30)

func randomize_size():
	size = randi_range(4,10)
