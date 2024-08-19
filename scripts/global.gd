extends Node

signal focus
signal play_music
signal play_impact_sound
signal hide_sprite

var scales = preload("res://scenes/game_area.tscn")
var inventory = preload("res://scenes/inventory.tscn")

var blackscreen: bool = true
var mouse_input: bool = true
var scales_visible: bool = false
var inv_visible: bool = false
var game_started: bool = false

var weight_diff: float

# Dialog functions
func set_mouse_input(cond: bool) -> void:
	mouse_input = cond

func show_scales() -> void:
	var instance = scales.instantiate()
	add_child(instance)
	scales_visible = true

func show_inventory() -> void:
	var instance = inventory.instantiate()
	add_child(instance)
	inv_visible = true

func show_sprite(_sprite: String) -> void:
	pass

func play_sound(_sound: String) -> void:
	pass

func place_feather() -> void:
	pass
