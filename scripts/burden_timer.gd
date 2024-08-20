extends Timer

var items_spawned: int = 0

func _ready() -> void:
	wait_time = 0.5
	timeout.connect(_timeout)

func _timeout() -> void:	
	if Global.game_started:
		if items_spawned >= 3:
			wait_time = 1.5
		if items_spawned >= 10:
			wait_time = 1.2
		if items_spawned >= 18:
			wait_time = 0.9
		if items_spawned >= 35:
			wait_time = 0.7
		if Global.game_mode == Global.GameMode.SURVIVAL:
			if items_spawned >= 80:
				wait_time = 0.5
			if items_spawned >= 130:
				wait_time = 0.4
			if items_spawned >= 180:
				wait_time = 0.3
			if items_spawned >= 210:
				wait_time = 0.2
		print("objects: %s" % items_spawned)
		print("wait time: %s" % wait_time)
		$"../Controllers/ObjectController".launch_random_scarab()
		items_spawned += 1
