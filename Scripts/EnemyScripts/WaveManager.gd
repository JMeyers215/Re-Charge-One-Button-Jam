extends Node2D

@export var wave_count : int = 1
@export var wave_one : PackedScene
@export var wave_two : PackedScene
@export var wave_three : PackedScene
@export var wave_four : PackedScene
@export var wave_five : PackedScene
@export var wave_six : PackedScene
@export var wave_seven : PackedScene
@export var wave_eight : PackedScene
var enemy_group

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enemy_group = get_tree().get_nodes_in_group("Enemy")
	

func start_wave():
	var wave
	if wave_count == 1:
		wave = wave_one.instantiate()
	elif wave_count == 2:
		wave = wave_two.instantiate()
	elif wave_count == 3:
		wave = wave_three.instantiate()
	elif wave_count == 4:
		wave = wave_four.instantiate()
	elif wave_count == 5:
		wave = wave_five.instantiate()
	elif wave_count == 6:
		wave = wave_six.instantiate()
	elif wave_count == 7:
		wave = wave_seven.instantiate()
	elif wave_count == 8:
		wave = wave_eight.instantiate()
	
	add_child(wave)

func enemies_defeated():
	if enemy_group.size()-1 == 0:
		wave_count += 1
		start_wave()

