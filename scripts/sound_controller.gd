extends Node

func _on_marble_impact() -> void:
	%ImpactSound.play()	

func _on_coin_impact() -> void:
	%ImpactSound.play()

func _on_mouse_controllable_pickup() -> void:
	%PickupSound.play()
