extends Node

var rng = RandomNumberGenerator.new()
var scene: Node
var totalSpawnRate
var burdens
var scarabScene = load("res://scenes/scarab.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scene = get_parent()
	burdens = %Burdens.get_children()
	totalSpawnRate = burdens.map(func(burden): return burden.spawnRate).reduce(func(a, n): return a + n, 0)

func add_script(node: Node, scriptNode: Node):
	var scriptCopy = scriptNode.duplicate()
	scriptCopy.objectController = self
	node.add_child(scriptCopy)

func create_scarab(target: Node2D, despawnTarget: Node2D) -> Node2D:
	var scarab = scarabScene.instantiate()
	scarab.target = target
	scarab.despawnTarget = despawnTarget
	return scarab

func launch_scarab(scarab: Node2D, spawnPoint: Vector2) -> void:
	scene.add_child(scarab)
	scarab.global_position = spawnPoint
	scarab.look_at(scarab.target.global_position)

enum Side { LEFT, RIGHT }
func launch_scarab_drop(object: Node2D, side: Side):
	var target: Node2D
	var despawnTarget: Node2D
	var spawn: Node2D
	match (side):
		Side.LEFT:
			target = %ScarabDropLeft
			despawnTarget = %ScarabDespawnRight
			spawn = %ScarabSpawnLeft
		Side.RIGHT:
			target = %ScarabDropRight
			despawnTarget = %ScarabDespawnRight
			spawn = %ScarabSpawnRight
	var scarab = create_scarab(target, despawnTarget)
	scarab.carry(object)
	scarab.state = Scarab.State.DELIVERING
	launch_scarab(scarab, spawn.global_position)

func launch_random_burden() -> void:
	var choice = rng.randf_range(0, totalSpawnRate)
	var toLaunch = burdens[burdens.size() - 1]
	for b in burdens:
		choice -= b.spawnRate
		if choice < 0:
			toLaunch = b
			break
	print("Launching: ", toLaunch.name)
	var duplicated = toLaunch.duplicate()
	add_script(duplicated, %MouseControllable)
	add_script(duplicated, %Respawns)
	var side
	if (rng.randi() % 2):
		side = Side.RIGHT
	else:
		side = Side.RIGHT
	launch_scarab_drop(duplicated, side)

func launch_random_scavenger() -> void:
	var liveBurdens = scene.get_children().filter(is_burden)
	var idx = rng.randi_range(0, liveBurdens.size() - 1)
	var target = liveBurdens[idx]
	print ("Scavenging: ", target.name)
	var side
	if rng.randi() % 2:
		side = Side.LEFT
	else:
		side = Side.RIGHT
	var despawnTarget: Node2D
	var spawn: Node2D
	match (side):
		Side.LEFT:
			despawnTarget = %ScarabDespawnRight
			spawn = %ScarabSpawnLeft
		Side.RIGHT:
			despawnTarget = %ScarabDespawnRight
			spawn = %ScarabSpawnRight
	var scarab = create_scarab(target, despawnTarget)
	scarab.state = Scarab.State.SCAVENGING
	launch_scarab(scarab, spawn.global_position)

func is_burden(obj):
	var asBurden = obj as Burden
	return asBurden != null

func launch_random_scarab() -> void:
	var targetCount = 30
	var liveBurdens = scene.get_children().filter(is_burden)
	var createRand = rng.randi_range(0, targetCount + liveBurdens.size() - 1)
	if createRand < targetCount:
		launch_random_burden()
	else:
		launch_random_scavenger()

func place_object_in_scene(object: Node2D, position: int = 1) -> void:
	var pos: Vector2
	match position:
		0: pos = %RespawnPoint1.position
		1: pos = %RespawnPoint2.position
	
	if object.get_parent() != scene:
		if object.get_parent():
			object.get_parent().remove_child(object)
		scene.add_child(object)
		object.position = pos
	
	var rigidObject = object as RigidBody2D
	if rigidObject:
		rigidObject.freeze = true
		PhysicsServer2D.body_set_state(
			rigidObject.get_rid(),
			PhysicsServer2D.BODY_STATE_TRANSFORM,
			Transform2D.IDENTITY.translated(pos)
		)
		if rigidObject.has_method("enable_collision"):
			rigidObject.enable_collision()
		rigidObject.freeze = false
	else:
		object.position = pos
