extends Node

signal focus
signal play_music
signal play_impact_sound
signal hide_sprite
signal restart
signal toggle_music
signal charge_changed

var scales = preload("res://scenes/game_area.tscn")
var inventory = preload("res://scenes/inventory.tscn")
var game_over = preload("res://scenes/game_over.tscn")

enum GameMode { SURVIVAL, CHARGE}
var game_mode = GameMode.CHARGE

var blackscreen: bool = true
var mouse_input: bool = true
var scales_visible: bool = false
var inv_visible: bool = false
var game_started: bool = false
var first_time: bool = true
var music_muted: bool = false

var weight_diff: float
var max_diff: float = 140
var time_score: float = 0
var charge: float = 0
var high_score: float = 0
var fastest_charge: float = 0

func end_game() -> void:
	var instance = game_over.instantiate()
	add_child(instance)
	game_started = false

func update_scoring(delta: float) -> void:
	if game_started:
		time_score += delta
		match game_mode:
			GameMode.SURVIVAL:
				if weight_diff > max_diff:
					if time_score > high_score:
						high_score = time_score
					end_game()
			GameMode.CHARGE:
				charge += (0.8 - weight_diff / max_diff) * delta * 2
				charge_changed.emit(charge)
				# Lose condition
				if charge < -2:
					end_game()
				if charge > 60:
					if fastest_charge == 0 or time_score < fastest_charge:
						fastest_charge = time_score
					end_game()

func restart_game() -> void:
	weight_diff = 0
	charge = 0
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
