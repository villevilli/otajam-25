extends Node2D
class_name Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Scene Ready")
	if get_parent() is LevelManager:
		var manager: LevelManager = get_parent()
		print("Parent Found")
		print(get_children())
		var entrypoint: Node2D = find_child(manager.entrypoint)
		print(entrypoint)
		if entrypoint != null:
			(get_node("Player") as Player).position=entrypoint.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
