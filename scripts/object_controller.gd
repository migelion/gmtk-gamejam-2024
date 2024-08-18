extends Node

var rng = RandomNumberGenerator.new()
var scene: Node
var totalSpawnRate
var burdens

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scene = get_parent()
	burdens = %Burdens.get_children()
	totalSpawnRate = burdens.map(func(burden): return burden.spawnRate).reduce(func(a, n): return a + n, 0)

func add_script(node: Node, scriptNode: Node):
	var scriptCopy = scriptNode.duplicate()
	scriptCopy.objectController = self
	node.add_child(scriptCopy)

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
	place_object_in_scene(duplicated)

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
	if (rigidObject):
		rigidObject.freeze = true
		PhysicsServer2D.body_set_state(
			rigidObject.get_rid(),
			PhysicsServer2D.BODY_STATE_TRANSFORM,
			Transform2D.IDENTITY.translated(pos)
		)
		rigidObject.freeze = false
	else:
		object.position = pos
