extends Panel

func _ready() -> void:
	Global.focus.connect(fade_out)
	visible = true
		
func fade_out() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color("ffffff00"), 1.5)\
		.set_trans(Tween.TRANS_LINEAR)
	Global.blackscreen = false
