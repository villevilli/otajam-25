extends Node2D
class_name Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var entrypoint: Node2D = find_child(LevelManager.entrypoint)
	if entrypoint != null:
		(get_node("Player") as Player).position=entrypoint.position
		(get_node("Camera") as Camera2D).position=entrypoint.position
