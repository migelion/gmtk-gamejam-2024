extends Node

var time_running: bool = false

func _ready() -> void:
	Global.restart.connect(restart)

func _process(delta: float) -> void:
	if time_running:
		match Global.game_mode:
			Global.GameMode.SURVIVAL:
				%Time.text = "Time: %8.2f\nHigh Score: %8.2f" % [Global.time_score, Global.high_score]
			Global.GameMode.CHARGE:
				if Global.fastest_charge != 0:
					%Time.text = ("Charge: %8.2f\nTime: %8.2f\nFastest Fill Time: %8.2f"
					   % [Global.charge, Global.time_score, Global.fastest_charge])
				else:
					%Time.text = ("Charge: %8.2f\nTime: %8.2f" % [Global.charge, Global.time_score])

	# Start timer
	if Global.game_started and not time_running:
		Global.time_score = 0
		time_running = true
		
	# Stop timer
	if not Global.game_started and time_running:
		time_running = false


func restart() -> void:
	$"../..".queue_free()
