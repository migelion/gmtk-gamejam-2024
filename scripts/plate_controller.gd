extends Node

func _ready() -> void:
	%PlateController.visible = false

func _process(delta: float) -> void:
	if Global.game_started and !%PlateController.visible:
		%PlateController.visible = true
	
	var left_y = %LeftPlate.position.y
	var right_y = %RightPlate.position.y
	
	Global.weight_diff = abs(left_y - right_y)
	Global.update_scoring(delta)
	var percent = Global.balance_percent * 100
	$BalanceLabel.text = "%4.0f" % percent

	var color := Color.WHITE
	if percent > 90:
		color = Color.GREEN
	elif percent < 0:
		color = Color.RED
		
	$Label.set("theme_override_colors/font_color", color)
	$BalanceLabel.set("theme_override_colors/font_color", color)
