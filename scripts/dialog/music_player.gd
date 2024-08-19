extends AudioStreamPlayer

var muted: bool = false

func _ready() -> void:
	Global.play_music.connect(play_music)
	Global.toggle_music.connect(toggle_music)

func play_music() -> void:
	play()

func toggle_music() -> void:
	muted = !muted
	
	match muted:
		true: volume_db = -80
		false: volume_db = -10
