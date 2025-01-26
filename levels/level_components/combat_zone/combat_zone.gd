@tool
extends Node2D

@export var enemy_health: int = 50
@onready var level: Level = $".."
@onready var area: Area2D = $"InnerArea"

@export var required_quest: StringName = ""
@export var excluded_by_quest: StringName = ""
@export var combat_quest_track: StringName = ""

func _ready() -> void:
	area.body_entered.connect(_on_inner_area_body_entered)
	if required_quest == "ReturnToChararas":
		return
	
	if required_quest && QuestManager.get_quest_by_name(required_quest) == null:
		visible = false
		return

	if excluded_by_quest && QuestManager.get_quest_by_name(excluded_by_quest) != null:
		visible = false
		return


@export var collider_size: Vector2 = Vector2(512, 512):
	# Update speed and reset the rotation.
	set(new_size):
		collider_size = new_size
		var collider1: CollisionShape2D = get_node("InnerArea/CollisionShape2D")
		var shape: RectangleShape2D = collider1.shape
		shape.size = new_size

func _on_inner_area_body_entered(_body: Node2D) -> void:
	if required_quest && QuestManager.get_quest_by_name(required_quest) == null:
		print("required_quest null")
		return

	if excluded_by_quest && QuestManager.get_quest_by_name(excluded_by_quest) != null:
		return
	print("entered combat zone")
	area.set_deferred("monitoring", false)
	#hide()

	var quest := QuestManager.get_quest_by_name(combat_quest_track)

	if quest is Combat_Quest:
		(quest as Combat_Quest).current_kill_count += 1

	level.start_battle()
