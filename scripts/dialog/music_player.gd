extends AudioStreamPlayer


func _ready() -> void:
	Global.play_music.connect(play_music)

func play_music() -> void:
	play()
