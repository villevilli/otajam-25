extends Resource
class_name Quest

@export var quest_name: String
@export var quest_description: String

var is_active: bool = false

func _ready() -> void:
	QuestManager.connect("quest_started", _quest_started)
	QuestManager.connect("quest_finished", _quest_finished)
	pass

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
	pass

## Function to finish this quest
func complete() -> void:
	QuestManager.emit_signal("quest_completed", self)

## Function to start this quest
func start() -> void:
	QuestManager.emit_signal("quest_started", self)
