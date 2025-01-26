@tool
extends Node2D

@export var enemy_health: int = 50
@onready var level: Level = $".."
@onready var area: Area2D = $"InnerArea"

func _ready()->void:
	area.body_entered.connect(_on_inner_area_body_entered)

@export var collider_size: Vector2 = Vector2(512,512):
	# Update speed and reset the rotation.
	set(new_size):
		collider_size=new_size
		var collider1: CollisionShape2D = get_node("InnerArea/CollisionShape2D")
		var shape: RectangleShape2D = collider1.shape
		shape.size=new_size

func _on_inner_area_body_entered(_body: Node2D) -> void:
	print("entered combat zone")
	area.monitoring=false
	level.start_battle()
