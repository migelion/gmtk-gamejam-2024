extends Node

func _ready() -> void:
	Global.play_impact_sound.connect(play_impact_sound)

func play_impact_sound() -> void:
	%ImpactSound.play()

func _on_mouse_controllable_pickup() -> void:
	%PickupSound.play()
