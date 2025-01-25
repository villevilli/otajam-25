extends ScrollContainer

var quest_item := preload("res://user_interface/QuestList/QuestItem.tscn")
var _quest_items: Dictionary

@onready var active_quest_container := $"%QuestContainer"
@onready var finished_quest_container := $"%FinishedQuestContainer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	QuestManager.quest_started.connect(_quest_started)
	QuestManager.quest_finished.connect(_quest_finished)
	QuestManager.quests_changed.connect(_regenerate_quest_lists)

	_regenerate_quest_lists()

	
func _regenerate_quest_lists() -> void:
	for child in active_quest_container.get_children() + finished_quest_container.get_children():
		child.queue_free()
	
	for quest in QuestManager.active_quests:
		_add_quest(quest, active_quest_container)
	for quest in QuestManager.completed_quests:
		_add_quest(quest, finished_quest_container)


func _quest_started(quest: Quest) -> void:
	_add_quest(quest, finished_quest_container)

func _quest_finished(quest: Quest) -> void:
	_finish_quest(quest)

func _add_quest(quest: Quest, container: Node) -> void:
	var quest_item_instance := (quest_item.instantiate() as QuestItem)
	quest_item_instance.quest = quest

	container.add_child(quest_item_instance)
	_quest_items[quest] = quest_item_instance

func _finish_quest(quest: Quest) -> void:
	(_quest_items[quest] as QuestItem).reparent(finished_quest_container)
