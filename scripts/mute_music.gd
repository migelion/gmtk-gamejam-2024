extends Button

var music: bool = true

func toggle_music() -> void:
	Global.toggle_music.emit()
	music = !music
	
	if music:
		$MusicOn.visible = true
		$MusicOff.visible = false
	else:
		$MusicOn.visible = false
		$MusicOff.visible = true

func _on_pressed() -> void:
	toggle_music()
