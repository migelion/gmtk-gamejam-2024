extends Node

func _ready() -> void:
	Global.restart.connect(restart)

func restart() -> void:
	$"../..".queue_free()
