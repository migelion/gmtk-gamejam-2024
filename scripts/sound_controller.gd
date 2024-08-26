extends Node

func _ready() -> void:
	Events.play_impact_sound.connect(play_impact_sound)

func play_impact_sound() -> void:
	%ImpactSound.play()

func _on_mouse_controllable_pickup() -> void:
	%PickupSound.play()

func _on_mouse_controllable_drop() -> void:
	%DropSound.play()
