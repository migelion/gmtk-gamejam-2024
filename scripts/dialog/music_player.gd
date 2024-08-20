extends AudioStreamPlayer

#var muted: bool = false

func _ready() -> void:
	Global.play_music.connect(play_music)
	Global.toggle_music.connect(toggle_music)

func play_music() -> void:
	play()
	toggle_music()
	$"../IntroMusicPlayer".stop()

func toggle_music() -> void:
	match Global.music_muted:
		true: volume_db = -80
		false: volume_db = -10
