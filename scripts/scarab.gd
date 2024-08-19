extends Node2D

class_name Scarab

@export var target: Node2D
@export var despawnTarget: Node2D
@export var speed: float = 300
@export var carried_object: Node2D
@export var turnRadius: float = 100

enum State {DELIVERING, SCAVENGING, LEAVING}
@export var state = State.LEAVING

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func carry(object: Node2D):
	assert(carried_object == null)
	carried_object = object
	if object.get_parent() and object.get_parent() != self:
		object.get_parent().remove_child(object)
	object.position = Vector2(0,0)
	object.rotation = 0
	var rigid = object as RigidBody2D
	if rigid:
		rigid.freeze = true
	add_child(object)

func drop():
	var carried_position = carried_object.global_position
	var carried_rotation = carried_object.global_rotation
	remove_child(carried_object)
	get_parent().add_child(carried_object)
	carried_object.global_position = carried_position
	carried_object.global_rotation = carried_rotation
	var carried_rigid = carried_object as RigidBody2D
	if carried_rigid:
		carried_rigid.freeze = false
		carried_rigid.apply_central_impulse(
			Vector2.RIGHT.rotated(global_rotation) * speed * carried_rigid.mass)
	carried_object = null

func turn_toward(target_location, delta):
	var target_rotation = global_position.angle_to_point(target_location)
	var current_rotation = global_rotation
	target_rotation = fmod(target_rotation, 2 * PI)
	current_rotation = fmod(current_rotation, 2 * PI)
	if (target_rotation > current_rotation + PI):
		target_rotation -= 2 * PI
	if (target_rotation < current_rotation - PI):
		target_rotation += 2 * PI
	var local_turn_radius = min(turnRadius, global_position.distance_to(target_location) / 2)
	var max_change = delta * speed / local_turn_radius
	if abs(target_rotation - current_rotation) < max_change:
		global_rotation = target_rotation
	else:
		global_rotation = current_rotation + sign(target_rotation - current_rotation) * max_change

func _physics_process(delta: float) -> void:
	if (!is_instance_valid(target)):
		target = despawnTarget
		state = State.LEAVING
	var target_location = target.global_position
	turn_toward(target_location, delta)
	global_position += Vector2.RIGHT.rotated(global_rotation) * delta * speed
	if global_position.distance_squared_to(target_location) < 10:
		arrive()

func arrive():
	match (state):
		State.DELIVERING:
			if carried_object:
				drop()
			target = despawnTarget
			state = State.LEAVING
		State.LEAVING:
			queue_free()
		State.SCAVENGING:
			carry(target)
			target = despawnTarget
			state = State.LEAVING
