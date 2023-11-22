extends Node2D

var wave_count : int = 1
var enemy_group

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enemy_group = get_tree().get_nodes_in_group("Enemy")
	

func start_wave():
	pass

func enemies_defeated():
	if enemy_group.size() == 0:
		wave_count += 1
		start_wave()

