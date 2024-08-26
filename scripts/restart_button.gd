extends Button

func _on_pressed() -> void:
	%MenuSound.play()
	$"..".visible = false
	Events.restart.emit()
	Global.restart_game()
	await get_tree().create_timer(1.0).timeout
	$"..".queue_free()
