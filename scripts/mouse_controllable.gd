extends Node


var grabbed = false
var parent: PhysicsBody2D
var parentCharacter: CharacterBody2D
var parentRigid: RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent() as PhysicsBody2D
	if (parent):
		parentCharacter = parent as CharacterBody2D
		parentRigid = parent as RigidBody2D
		parent.input_pickable = true
		parent.input_event.connect(_input_event)
	set_process_input(false)

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		if (event.is_pressed()):
			grabbed = true
			if parentRigid:
				parentRigid.freeze = true
				parentRigid.set_collision_layer_value(0b0001, false)
			if parentCharacter:
				parentCharacter.set_physics_process(false)
			grabbed = true
			set_process_input(true)

func _input(event: InputEvent):
	if grabbed:
		if (event is InputEventMouseButton):
			if (event.is_released()):
				if parentRigid:
					parentRigid.freeze = false
					parentRigid.set_collision_layer_value(0b0001, true)
				if parentCharacter:
					parentCharacter.set_physics_process(true)
				grabbed = false
				set_process_input(false)
		elif (event is InputEventMouseMotion):
			if parentRigid:
				parentRigid.global_position += event.relative
			if parentCharacter:
				parentCharacter.position += event.relative
