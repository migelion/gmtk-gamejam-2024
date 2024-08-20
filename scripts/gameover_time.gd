extends Label

func _process(_delta: float) -> void:
	$"../GameOver".text = Global.endgame_text
	var timeText = Global.time_text(Global.time_score)
	match Global.game_mode:
		Global.GameMode.SURVIVAL:
			text = "Score: %s" % timeText
		Global.GameMode.CHARGE:
			if Global.charge > 0:
				text = "Finished in: %s" % timeText
			else:
				text = "Failed. Lasted: %s" % timeText
