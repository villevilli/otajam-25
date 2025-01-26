@tool
extends Node2D

var dialog_system := preload("res://quests/dialog_system/dialog_system.tscn")
@export var dialog: DialogNode

@export_category("Entry Requirements")
@export var required_quest_must_be_complete: bool = false
@export var required_quest: StringName = ""
@export var excluded_by_quest: StringName = ""

@onready var area2d: Area2D = $InnerArea

func _ready() -> void:
	area2d.body_entered.connect(body_entered)

@export var collider_size: Vector2 = Vector2(512, 512):
	# Update speed and reset the rotation.
	set(new_size):
		collider_size = new_size
		var collider1: CollisionShape2D = get_node("InnerArea/CollisionShape2D")
		var shape: RectangleShape2D = collider1.shape
		shape.size = new_size

func body_entered(_body: Node2D) -> void:
	if Engine.is_editor_hint():
		return
	
	var required_quest_quest := QuestManager.get_quest_by_name(required_quest)

	if required_quest_must_be_complete && required_quest_quest != null:
		if !required_quest_quest.is_finished:
			return
	else:
		if required_quest && QuestManager.get_quest_by_name(required_quest) == null:
			return

	if excluded_by_quest && QuestManager.get_quest_by_name(excluded_by_quest) != null:
		return
	
	var dialog_system_instance: DialogSystem = dialog_system.instantiate()
	dialog_system_instance.start_dialog = dialog
	get_tree().root.add_child(dialog_system_instance)
