extends VBoxContainer

var quest_item := preload("res://user_interface/QuestList/QuestItem.tscn")
var _quest_items: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	QuestManager.quest_started.connect(_quest_started)
	QuestManager.quest_finished.connect(_quest_finished)

	for quest in QuestManager.active_quests:
		_add_quest(quest)


func _quest_started(quest: Quest) -> void:
	_add_quest(quest)

func _quest_finished(quest: Quest) -> void:
	_remove_quest(quest)

func _add_quest(quest: Quest) -> void:
	var quest_item_instance := (quest_item.instantiate() as QuestItem)
	quest_item_instance.quest = quest

	add_child(quest_item_instance)
	_quest_items[quest] = quest_item_instance

func _remove_quest(quest: Quest) -> void:
	(_quest_items[quest] as QuestItem).queue_free()
