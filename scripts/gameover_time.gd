extends Label

func _process(_delta: float) -> void:
	$"../GameOver".text = Global.endgame_text
	var timeText = Global.time_text(Global.time_score)
	match Global.game_mode:
		Global.GameMode.SURVIVAL:
			text = "Score: %s" % timeText
		Global.GameMode.CHARGE:
			if Global.charge > 0:
				text = "Congratulations! You were judged worthy. Welcome to Sekhet-Aaru, the Field of Reeds. The land is fertile, and you will live forever.\nYou made it through the trial in %s!" % timeText
			else:
				text = "I'm sorry. You were found wanting. Your heart has been devoured by the crocodile god, Ammit. You lasted %s before the end." % timeText
