@tool
extends RigidBody2D
class_name Burden

@export var spawnRate: float = 1
@export var makes_sound: bool = true

func _on_body_entered(_body: Node) -> void:
	if linear_velocity.y > 50:
		Global.play_impact_sound.emit()

func disable_collision() -> void:
	if self.has_node("Collision"):
		$Collision.disabled = true

func enable_collision() -> void:
	if self.has_node("Collision"):
		$Collision.disabled = false
