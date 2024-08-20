extends Label

func _process(_delta: float) -> void:
	match Global.game_mode:
		Global.GameMode.SURVIVAL:
			text = "Score: %7.2f" % Global.time_score
		Global.GameMode.CHARGE:
			if Global.score > 0:
				text = "Completed: %7.2f" % Global.time_score
			else:
				text = "Failed. Lasted: %7.2f" % Global.time_score
