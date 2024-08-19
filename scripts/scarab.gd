extends Node2D

@export var target: Node2D
@export var speed: float = 300
@export var carried_object: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var target_location = target.global_position
	look_at(target_location)
	global_position = global_position.move_toward(target_location, delta * speed)
	if global_position.is_equal_approx(target_location):
		if carried_object:
			var carried_position = carried_object.global_position
			var carried_rotation = carried_object.global_rotation
			remove_child(carried_object)
			get_parent().add_child(carried_object)
			carried_object.global_position = carried_position
			carried_object.global_rotation = carried_rotation
			var carried_rigid = carried_object as RigidBody2D
			if carried_rigid:
				carried_rigid.freeze = false
				carried_rigid.apply_central_impulse(Vector2.RIGHT.rotated(global_rotation) * speed / 5)
		queue_free()
