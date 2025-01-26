extends Control
class_name QuestItem

@export var quest: Quest

@onready var quest_name_label: Label = $"%QuestName"
@onready var quest_description_label: Label = $"%QuestDescription"

func _ready() -> void:
	quest_name_label.text = quest.quest_name.capitalize()

func _process(_delta: float) -> void:
	quest_description_label.text = quest.get_description()
