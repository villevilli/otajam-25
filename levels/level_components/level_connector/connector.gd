@tool
extends Node2D

@export var target_level_name: String =""
@export var spawn_pos_name: String=""

@export var collider_size: Vector2 = Vector2(512,512):
	# Update speed and reset the rotation.
	set(new_size):
		collider_size=new_size
		var collider1: CollisionShape2D = get_node("InnerArea/CollisionShape2D")
		var shape: RectangleShape2D = collider1.shape
		shape.size=new_size

func _on_inner_area_body_entered(_body: Node2D) -> void:
	#TODO Check if is player, tho shouldn't matter since on own layer.
	LevelManager.levelchange.emit(target_level_name, spawn_pos_name)
	#LevelManager.switch_level(target_level_name, spawn_pos_name)
