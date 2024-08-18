extends Node

@export var floorLevel: float = 750
var parent
var objectController

func _ready() -> void:
	parent = get_parent() as Node2D

func _physics_process(_delta: float) -> void:
	if parent and objectController:
		if parent.position.y > floorLevel:
			objectController.place_object_in_scene(parent, randi() % 2)
