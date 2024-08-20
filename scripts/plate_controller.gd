extends Node

func _process(delta: float) -> void:
	var left_y = %LeftPlate.position.y
	var right_y = %RightPlate.position.y
	
	Global.weight_diff = abs(left_y - right_y)
	Global.update_scoring(delta)
	var percent = 100 - (Global.weight_diff / Global.max_diff * 100)
	$BalanceLabel.text = "%4.0f" % percent
