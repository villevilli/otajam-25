extends Node
class_name quest_manager

## This should not be edited manually
## Start and Complete quests with the quest_started and quest_finished signals respectively
var active_quests: Array[Quest]

## This should not be edited manually
## Start and Complete quests with the quest_started and quest_finished signals respectively
var completed_quests: Array[Quest]

var quests: Dictionary

## Emitted for quests starting
signal quest_started(quest: Quest)

## Emitted for quests being finished
signal quest_finished(quest: Quest)

## Emitted when quest lists should be reloaded
signal quests_changed

func serialize() -> Dictionary:
	var dict: Dictionary = {
		"active_quests": [],
		"completed_quests": []
	}

	for quest in active_quests:
		(dict["active_quests"] as Array[Dictionary]).append(quest.serialize())
	for quest in completed_quests:
		(dict["completed_quests"] as Array[Dictionary]).append(quest.serialize())
	return dict

func deserialize(dict: Dictionary) -> void:
	active_quests.clear()
	completed_quests.clear()

	active_quests.append_array((dict["active_quests"] as Array[Dictionary]).map(Quest.from_serialized))
	completed_quests.append_array((dict["completed_quests"] as Array[Dictionary]).map(Quest.from_serialized))

	quests_changed.emit()

	
func get_quest_by_name(quest_name: StringName) -> Quest:
	for quest in active_quests:
		if quest.quest_name == quest_name:
			return quest

	for quest in completed_quests:
		if quest.quest_name == quest_name:
			return quest
	
	return null


func _ready() -> void:
	quest_finished.connect(_quest_finished)
	quest_started.connect(_quest_started)
	pass # Replace with function body.


func _quest_finished(quest: Quest) -> void:
	for i in range(len(active_quests)):
		if active_quests[i] == quest:
			completed_quests.append(active_quests.pop_at(i))

func _quest_started(quest: Quest) -> void:
	active_quests.append(quest)
