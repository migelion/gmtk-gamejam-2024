extends Node

var time_running: bool = false

func _ready() -> void:
	Events.restart.connect(restart)
	%Time.visible = false
	$"../MuteMusic".visible = false
	$"../../Ui".visible = false
	$"../../Panel".visible = false
	
func _process(delta: float) -> void:
	if Global.game_started and !%Time.visible:
		%Time.visible = true
		$"../MuteMusic".visible = true
		$"../../Ui".visible = true
		$"../../Panel".visible = true
	
	if time_running:
		match Global.game_mode:
			Global.GameMode.SURVIVAL:
				%Time.text = "Time: %s\nHigh Score: %s" % [Global.time_text(Global.time_score), Global.time_text(Global.high_score)]
			Global.GameMode.CHARGE:
				if Global.fastest_charge != 0:
					%Time.text = ("Time: %s\nFastest Win Time: %s"
					   % [Global.time_text(Global.time_score, true), Global.time_text(Global.fastest_charge, true)])
				else:
					%Time.text = ("Time: %s" % [Global.time_text(Global.time_score, true)])

	# Start timer
	if Global.game_started and not time_running:
		Global.time_score = 0
		time_running = true
		
	# Stop timer
	if not Global.game_started and time_running:
		time_running = false


func restart() -> void:
	$"../..".queue_free()
