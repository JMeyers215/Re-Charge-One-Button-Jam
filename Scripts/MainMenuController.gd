extends Control

var select_counter : int = 1
var id_select : int = 1
var options_open : bool = false
var music_volume : float = 0.5
var sound_volume : float = 0.5

func _ready() -> void:
	$"../TitleElements/TitleAnimation".play()

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
		elif id_select == 2:
			if Input.is_action_pressed("one_button"):
				sound_volume += 0.01
				if sound_volume > 1:
					sound_volume = 0
				$Options/VolumeControls/AudioSlider.value = sound_volume
				$Options/VolumeControls/AudioSlider._on_value_changed(sound_volume)
				Global.sound_option = sound_volume
		elif select_counter == 30 && id_select == 3:
			pass
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


