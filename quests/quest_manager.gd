extends Resource
class_name quest_manager

## This should not be edited manually
## Start and Complete quests with the quest_started and quest_finished signals respectively
var active_quests: Array[Quest]

## This should not be edited manually
## Start and Complete quests with the quest_started and quest_finished signals respectively
var completed_quests: Array[Quest]

## Emitted for quests starting
signal quest_started(completed_quest: Quest)

## Emitted for quests being finished
signal quest_finished(started_quest: Quest)

func _ready() -> void:
	quest_finished.connect(_quest_finished)
	quest_started.connect(_quest_started)
	pass # Replace with function body.


func _quest_finished(quest: Quest) -> void:
	for i in range(len(active_quests)):
		if active_quests[i] == quest: active_quests.remove_at(i)

func _quest_started(quest: Quest) -> void:
	active_quests.append(quest)