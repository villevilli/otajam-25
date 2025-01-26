extends Node2D
class_name Level

@onready var player: Player = $"Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var entrypoint: Node2D = find_child(LevelManager.entrypoint)
	if entrypoint != null:
		(get_node("Player") as Player).position=entrypoint.position
		(get_node("Camera") as Camera2D).position=entrypoint.position

func start_battle() -> void:
	print("Entering Battle")
	var node: Node = (load("res://battle/battle.tscn") as PackedScene).instantiate()
	get_node("CanvasLayer").add_child(node)
	player.capturing_input=false
	get_tree().paused=false
	
func resume_game() -> void:
	player.capturing_input=true
	get_tree().paused=false
	get_node("CanvasLayer/Battle").queue_free()
 
