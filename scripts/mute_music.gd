extends Button

var music: bool = true

func _ready() -> void:
	check_state()

func toggle_music() -> void:
	Global.music_muted = !Global.music_muted
	Events.toggle_music.emit()
	check_state()

func check_state() -> void:
	if not Global.music_muted:
		$MusicOn.visible = true
		$MusicOff.visible = false
	else:
		$MusicOn.visible = false
		$MusicOff.visible = true

func _on_pressed() -> void:
	toggle_music()
