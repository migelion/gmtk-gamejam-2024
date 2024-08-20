extends Timer

var items_spawned: int = 0

@export var SURVIVAL_WAIT_TIMES = {
	0: 0.5,
	3: 1.5,
	10: 1.2,
	18: 0.9,
	35: 0.7,
	80: 0.5,
	130: 0.4,
	180: 0.3,
	210: 0.2
	}
var SURVIVAL_WAIT_TIME_KEYS = SURVIVAL_WAIT_TIMES.keys()

@export var CHARGE_WAIT_TIMES = {
	0: 0.4,
	4: 1.2,
	10: 1,
	18: 0.9,
	35: 0.7,
	}
var CHARGE_WAIT_TIME_KEYS = CHARGE_WAIT_TIMES.keys()

func _ready() -> void:
	SURVIVAL_WAIT_TIME_KEYS.sort()
	CHARGE_WAIT_TIME_KEYS.sort()
	update_wait_time()
	timeout.connect(_timeout)

func update_wait_time() -> void:
	var wait_times
	var wait_time_keys
	match Global.game_mode:
		Global.GameMode.SURVIVAL:
			wait_times = SURVIVAL_WAIT_TIMES
			wait_time_keys = SURVIVAL_WAIT_TIME_KEYS
		Global.GameMode.CHARGE:
			wait_times = CHARGE_WAIT_TIMES
			wait_time_keys = CHARGE_WAIT_TIME_KEYS
	var next_wait_time = 0.5
	for key in wait_time_keys:
		if key <= items_spawned:
			next_wait_time = wait_times[key]
		else:
			break
	wait_time = next_wait_time

func _timeout() -> void:
	if Global.game_started:
		update_wait_time()
		print("objects: %s" % items_spawned)
		print("wait time: %s" % wait_time)
		$"../Controllers/ObjectController".launch_random_scarab()
		items_spawned += 1
