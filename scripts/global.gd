extends Node

signal focus
signal play_music
signal play_impact_sound
signal hide_sprite
signal restart

var scales = preload("res://scenes/game_area.tscn")
var inventory = preload("res://scenes/inventory.tscn")
var game_over = preload("res://scenes/game_over.tscn")

var blackscreen: bool = true
var mouse_input: bool = true
var scales_visible: bool = false
var inv_visible: bool = false
var game_started: bool = false
var first_time: bool = true

var weight_diff: float
var max_diff: float = 10
var time_score: float = 0
var max_score: float = 0

func _process(delta: float) -> void:
	# Lose condition
	if weight_diff > max_diff and game_started:
		var instance = game_over.instantiate()
		add_child(instance)
		game_started = false
		
		if time_score > max_score:
			max_score = time_score
		
func restart_game() -> void:
	weight_diff = 0
	game_started = true
	get_tree().change_scene_to_file("res://scenes/dialog.tscn")
	show_scales()

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
