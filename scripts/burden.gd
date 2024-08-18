@tool
extends RigidBody2D
class_name Burden

@export var spawnRate: float = 1

signal impact

func _on_body_entered(body: Node) -> void:
	if linear_velocity.y > 60:
		impact.emit()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
