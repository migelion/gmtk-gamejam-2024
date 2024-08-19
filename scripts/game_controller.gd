extends Node

var time_running: bool = false

func _ready() -> void:
	Global.restart.connect(restart)

func _process(delta: float) -> void:
	if time_running:
		Global.time_score += delta
		%Time.text = "Time: %8.2f\nHigh Score: %8.2f" % [Global.time_score, Global.high_score]

	# Start timer
	if Global.game_started and not time_running:
		Global.time_score = 0
		time_running = true
		
	# Stop timer
	if not Global.game_started and time_running:
		time_running = false


func restart() -> void:
	$"../..".queue_free()
