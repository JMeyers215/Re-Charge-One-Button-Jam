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
	$WaveTimer.start()
	pass

func enemies_defeated():
	if enemy_group.size() == 0:
		$WaveTimer.time_left -= 30

func _on_wave_timer_timeout() -> void:
	wave_count += 1
	start_wave()

