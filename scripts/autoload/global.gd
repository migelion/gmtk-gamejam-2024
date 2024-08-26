extends Node

var scales = preload("res://scenes/game_area.tscn")
var inventory = preload("res://scenes/inventory.tscn")
var game_over = preload("res://scenes/game_over.tscn")

enum GameMode { SURVIVAL, CHARGE }
var game_mode = GameMode.CHARGE

var blackscreen: bool = true
var mouse_input: bool = true
var scales_visible: bool = false
var inv_visible: bool = false
var game_started: bool = false
var first_time: bool = true
var music_muted: bool = false

var max_diff: float = 140
var max_charge: float = 90
var min_charge: float = -4

var weight_diff: float
var time_score: float = 0
var charge: float = 0
var high_score: float = 0
var fastest_charge: float = 0
var endgame_text: String = ""
var balance_percent: float = 0

func end_game() -> void:
	var instance := game_over.instantiate()
	add_child(instance)
	game_started = false

func time_text(time: float, short: bool = false) -> String:
	if short:
		if Global.time_score < 60:
			return "%6.2fs" % time
		else:
			return "%02d:%.2f" % [floor(time / 60), fmod(time, 60)]
	else:
		if Global.time_score < 60:
			return "%6.2f seconds" % time
		elif Global.time_score < 120:
			return "1 minute %.2f seconds" % [fmod(time, 60)]
		else:
			return "%d minutes %.2f seconds" % [floor(time / 60), fmod(time, 60)]

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
				balance_percent = 1 - weight_diff / max_diff
				if balance_percent > 0.89:
					charge += balance_percent * delta * 3
				elif balance_percent > 0:
					charge += (balance_percent - 1) * delta
				elif balance_percent > -.2:
					charge += (balance_percent - 0.8) * delta * 3
				else:
					charge += (balance_percent - 0.9) * delta * 4
					
				Events.charge_changed.emit(charge)
				# Lose condition
				if charge < min_charge:
					endgame_text = "You failed!"
					end_game()
				if charge > max_charge:
					if fastest_charge == 0 or time_score < fastest_charge:
						fastest_charge = time_score
					endgame_text = "You succeeded!"
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
	var instance := scales.instantiate()
	add_child(instance)
	scales_visible = true

func show_inventory() -> void:
	var instance := inventory.instantiate()
	add_child(instance)
	inv_visible = true

func show_sprite(_sprite: String) -> void:
	pass

func play_sound(_sound: String) -> void:
	pass

func place_feather() -> void:
	pass
