extends Node2D

var resource: Resource
var line: DialogueLine
var typing: bool = false
var enabled: bool = true

func _ready() -> void:
	Global.hide_sprite.connect(hide_sprite)
	resource = load("res://assets/intro.dialogue")
	line = await resource.get_next_dialogue_line("start")
	new_line()
	
	if not Global.first_time:
		skip()

func _process(_delta: float) -> void:
	if Input.is_action_just_released(&"diag_continue") and Global.mouse_input and enabled:
		if not typing:
			line = await resource.get_next_dialogue_line(line.next_id)
			if line:
				new_line()
			else:
				end()
		else:
			%Text.skip_typing()
			typing = false

func new_line() -> void:
	if enabled:
		%Speaker.text = line.character
		%Text.dialogue_line = line
		%Text.type_out()
		typing = true

func skip() -> void:
	if not Global.scales_visible:
		Global.show_scales()
	if not Global.inv_visible:
		Global.show_inventory()
	if not $MusicPlayer.playing:
		$MusicPlayer.play_music()
	end()

func end() -> void:
	$DialogBox.queue_free()
	Global.game_started = true
	Global.first_time = false
	enabled = false

func hide_sprite() -> void:
	%CharacterSprite.visible = false

func _on_text_finished_typing() -> void:
	typing = false

func _on_skip_pressed() -> void:
	%MenuSound.play()
	skip()
