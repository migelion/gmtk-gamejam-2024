extends Label

func _process(_delta: float) -> void:
	text = "Score: %7.2f" % Global.time_score
