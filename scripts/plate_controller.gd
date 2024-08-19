extends Node

@export var balance_limit: float = 230

var diff: float

func _process(delta: float) -> void:
	var left_y = %LeftPlate.position.y
	var right_y = %RightPlate.position.y
	%LeftLabel.text = "%10.1f" % left_y
	%RightLabel.text = "%10.1f" % right_y
	
	diff = abs(left_y - right_y)
	$Label.text = "%10.1f" % abs(diff)
	
	if diff > balance_limit:
		$Label.text = "%10.1f\nOut of balance!" % diff
