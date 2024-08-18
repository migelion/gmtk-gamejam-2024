extends Node

var rng = RandomNumberGenerator.new()
var scene: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scene = get_parent()

func add_script(node: Node, scriptNode: Node):
	var scriptCopy = scriptNode.duplicate()
	scriptCopy.objectController = self
	node.add_child(scriptCopy)

func launch_random_burden() -> void:
	var count = %Burdens.get_child_count()
	var idx = rng.randi_range(0, count - 1)
	var toLaunch = %Burdens.get_child(idx)
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
