extends Node

func _process(delta: float) -> void:
	var left_y = %LeftPlate.position.y
	var right_y = %RightPlate.position.y
	
	Global.weight_diff = abs(left_y - right_y)
	$Label.text = "%10.1f" % Global.weight_diff
