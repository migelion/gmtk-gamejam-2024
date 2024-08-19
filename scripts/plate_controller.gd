extends Node

func _process(_delta: float) -> void:
	var left_y = %LeftPlate.position.y
	var right_y = %RightPlate.position.y
	
	Global.weight_diff = abs(left_y - right_y)
	var percent = 100 - (Global.weight_diff / Global.max_diff * 100)
	$Label.text = "Balance: %3.0f%%" % percent
