extends Timer

var items_spawned: int = 0

func _ready() -> void:
	wait_time = 0.5
	timeout.connect(_timeout)

func _timeout() -> void:
	if Global.game_started:
		if items_spawned > 4:
			wait_time = 3
		$"../Controllers/ObjectController".launch_random_burden()
		items_spawned += 1
