@tool
extends RigidBody2D
class_name Burden

@export var spawnRate: float = 1

signal impact

func _on_body_entered(body: Node) -> void:
	if linear_velocity.y > 60:
		impact.emit()
