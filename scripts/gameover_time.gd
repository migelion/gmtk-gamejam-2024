extends Label

func _process(delta: float) -> void:
	text = "Score: %7.2f" % Global.time_score
