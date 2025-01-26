extends Resource
class_name Quest

@export var quest_name: StringName
@export_multiline var quest_description: String

var is_active: bool = false
var is_finished: bool = false

func serialize() -> Dictionary:
	return {
		"quest_name": quest_name,
		"quest_description": quest_description,
		"is_active": is_active,
		"is_finished": is_finished,
	}

static func from_serialized(data: Dictionary) -> Quest:
	var quest := Quest.new()

	quest.quest_name = data.get("quest_name")
	quest.quest_description = data.get("quest_description")
	quest.is_active = data.get("is_active")
	quest.is_finished = data.get("is_finished")

	return quest

## Quest_started signal listener
func _quest_started(started_quest: Quest) -> void:
	if started_quest == self: _self_started()
	pass

## Helper function for when this quest is started
func _self_started() -> void:
	is_active = true
	pass

## quest_finished signal listener
func _quest_finished(finished_quest: Quest) -> void:
	if finished_quest == self: _self_finished()
	pass

## Helper function for when this quest is finished
func _self_finished() -> void:
	is_active = false
	is_finished = true
	pass

## Function to finish this quest
func complete() -> void:
	QuestManager.emit_signal("quest_finished", self)

## Function to start this quest
func start() -> void:
	QuestManager.connect("quest_started", _quest_started)
	QuestManager.connect("quest_finished", _quest_finished)

	QuestManager.emit_signal("quest_started", self)
