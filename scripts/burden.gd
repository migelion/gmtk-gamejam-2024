@tool
extends RigidBody2D
class_name Burden

@export var spawnRate: float = 1

func _on_body_entered(body: Node) -> void:
	if linear_velocity.y > 40:
		Global.play_impact_sound.emit()

func disable_collision() -> void:
	if self.has_node("CollisionShape2D"):
		$CollisionShape2D.disabled = true

func enable_collision() -> void:
	if self.has_node("CollisionShape2D"):
		$CollisionShape2D.disabled = false
