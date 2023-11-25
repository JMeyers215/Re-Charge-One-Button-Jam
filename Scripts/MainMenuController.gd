extends Control

var select_counter : int = 1
var id_select : int = 1
var options_open : bool = false
var music_volume : float = 0.5
var sound_volume : float = 0.5
var remapping : bool = false
var key_ready : bool = false
var new_key : InputEvent

func _ready() -> void:
	var input_event = InputEventKey.new()
	var input_keycode : String = Global.keybind
	input_event.keycode = OS.find_keycode_from_string(input_keycode)
	InputMap.action_erase_events("one_button")
	InputMap.action_add_event("one_button",input_event)
	$"../CurrentKey/KeyCode".text = str(": ", input_event.as_text_keycode())
	$"../TitleElements/TitleAnimation".play() 
	music_volume = Global.music_option
	sound_volume = Global.sound_option	
	$Options/VolumeControls/MusicSlider.value = music_volume
	$Options/VolumeControls/MusicSlider._on_value_changed(music_volume)
	$Options/VolumeControls/AudioSlider.value = sound_volume
	$Options/VolumeControls/AudioSlider._on_value_changed(sound_volume)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("one_button"):
		id_select += 1
		select_counter = 0
		$Buttons/PlayBar.value = 0
		$Buttons/OptionsBar.value = 0
		$Buttons/ExitBar.value = 0
		$Options/Keybind/KeybindBar.value = 0
		$Options/QuitBar.value = 0
		$"../OptionSelectNoise".play() 
	
	if remapping == true && key_ready == true:
		set_keybind(event)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("one_button"):
		select_counter += 1
		$Buttons/PlayBar.value = select_counter
		$Buttons/OptionsBar.value = select_counter
		$Buttons/ExitBar.value = select_counter
		$Options/QuitBar.value = select_counter
		$Options/Keybind/KeybindBar.value = select_counter
	if options_open == false:
		if select_counter == 30 && id_select == 1:
			get_tree().change_scene_to_file("res://Scenes/main.tscn")
		elif select_counter == 30 && id_select == 2:
			options_open = true
			$Buttons.visible = false
			$Options.visible = true
			$"../TitleElements".visible = false
		elif select_counter == 30 && id_select == 3:
			Global.save_game()
			get_tree().quit()
		if id_select == 4:
			id_select = 1
		if id_select == 1:
			$Buttons/PlayHover.visible = true
			$Buttons/OptionsHover.visible = false
			$Buttons/ExitHover.visible = false
			$Buttons/PlayBar.visible = true
			$Buttons/OptionsBar.visible = false
			$Buttons/ExitBar.visible = false
		elif id_select == 2:
			$Buttons/PlayHover.visible = false
			$Buttons/OptionsHover.visible = true
			$Buttons/ExitHover.visible = false
			$Buttons/PlayBar.visible = false
			$Buttons/OptionsBar.visible = true
			$Buttons/ExitBar.visible = false
		elif id_select == 3:
			$Buttons/PlayHover.visible = false
			$Buttons/OptionsHover.visible = false
			$Buttons/ExitHover.visible = true
			$Buttons/PlayBar.visible = false
			$Buttons/OptionsBar.visible = false
			$Buttons/ExitBar.visible = true
	if options_open == true:
		if id_select == 5:
			id_select = 1
		if id_select == 1:
			if Input.is_action_pressed("one_button"):
				music_volume += 0.01
				if music_volume > 1:
					music_volume = 0
				$Options/VolumeControls/MusicSlider.value = music_volume
				$Options/VolumeControls/MusicSlider._on_value_changed(music_volume)
				Global.music_option = music_volume
				Global.save_game()
		elif id_select == 2:  
			if Input.is_action_pressed("one_button"):
				sound_volume += 0.01
				if sound_volume > 1:
					sound_volume = 0
				$Options/VolumeControls/AudioSlider.value = sound_volume
				$Options/VolumeControls/AudioSlider._on_value_changed(sound_volume)
				Global.sound_option = sound_volume
				Global.save_game()
		elif select_counter == 30 && id_select == 3:
			remapping = true
			$"../KeybindTimer".start()
			InputMap.action_erase_events("one_button")
			$"../CurrentKey/KeyCode".text = str(": ")    
			$Options.visible = false
			$Buttons.visible = false
			$Rebind.visible = true
		elif select_counter == 30 && id_select == 4:
			options_open = false
			$Options.visible = false
			$Buttons.visible = true
			$"../TitleElements".visible = true
		if id_select == 1:
			$Options/VolumeControls/MusicHover.visible = true
			$Options/QuitHover.visible = false
			$Options/QuitBar.visible = false
		elif id_select == 2:
			$Options/VolumeControls/MusicHover.visible = false
			$Options/VolumeControls/SoundHover.visible = true
		elif id_select == 3:
			$Options/VolumeControls/SoundHover.visible = false
			$Options/Keybind/KeybindBar.visible = true
			$Options/Keybind/KeybindHover.visible = true
		elif id_select == 4:
			$Options/Keybind/KeybindBar.visible = false
			$Options/Keybind/KeybindHover.visible = false
			$Options/QuitHover.visible = true
			$Options/QuitBar.visible = true

func set_keybind(event):
	new_key = event
	if event is InputEventKey && event.pressed:
		InputMap.action_add_event("one_button",new_key)
		$"../CurrentKey/KeyCode".text = str(": ", new_key.as_text())
		$Options.visible = true
		$Rebind.visible = false
		remapping = false
		key_ready = false
		select_counter = 0
		Global.keybind = new_key.as_text() 

func _on_keybind_timer_timeout() -> void:
	key_ready = true

