extends Label

func _process(_delta: float) -> void:
	$"../GameOver".text = Global.endgame_text
	match Global.game_mode:
		Global.GameMode.SURVIVAL:
			text = "Score: %7.2f" % Global.time_score
		Global.GameMode.CHARGE:
			if Global.charge > 0:
				text = "Finished in: %6.2f seconds" % Global.time_score
			else:
				text = "Failed. Lasted: %6.2f seconds" % Global.time_score
