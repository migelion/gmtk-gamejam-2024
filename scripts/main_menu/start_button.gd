extends Button


func _on_pressed() -> void:
	%MenuSound.play()
	get_tree().change_scene_to_file("res://scenes/dialog.tscn")
