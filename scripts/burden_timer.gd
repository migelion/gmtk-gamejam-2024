extends Timer

var items_spawned: int = 0

func _ready() -> void:
	wait_time = 0.5
	timeout.connect(_timeout)

func _timeout() -> void:	
	if Global.game_started:
		if items_spawned >= 3:
			wait_time = 2
		if items_spawned >= 20:
			wait_time = 1.5
		if items_spawned >= 40:
			wait_time = 1
		print("objects: %s" % items_spawned)
		print("wait time: %s" % wait_time)
		$"../Controllers/ObjectController".launch_random_scarab()
		items_spawned += 1
