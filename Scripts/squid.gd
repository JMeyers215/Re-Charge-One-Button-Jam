extends Node2D

var tentacle_id : int = 0
var squid : Array 
@export var tentacle_counter : Timer 

func _ready():
	squid = get_tree().get_nodes_in_group("Tentacle")

func _process(delta):
	for tentacle in squid:
		if tentacle.tentacle_id == tentacle_id && tentacle.extended == false:
			tentacle.extended = true
		elif tentacle.tentacle_id != tentacle_id && tentacle.extended == true:
			tentacle.extended = false

func _input(event):
	if Input.is_action_just_pressed("one_button") && $"..".paused == false:
		extend_tentacle()
	elif Input.is_action_pressed("one_button"):
		pass

func extend_tentacle():
	tentacle_counter.stop()
	$SlapTimer.start()
	for tentacle in squid:
		if tentacle.tentacle_id == tentacle_id && tentacle.slap == false:
			tentacle.slap = true
			tentacle.slaptimer.start()

func _on_tentacle_counter_timeout():
	tentacle_id += 1
	if tentacle_id > 8:
		tentacle_id = 1
	print(tentacle_id)


func _on_slap_timer_timeout() -> void:
	tentacle_counter.start()
