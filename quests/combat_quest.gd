extends Quest
class_name Combat_Quest

@export var kill_count_requirement: int
var current_kill_count := 0:
    set(value):
        current_kill_count = value
        if value >= kill_count_requirement: complete()

func get_description() -> String:
    return (quest_description + "\n Kills left" + str(current_kill_count) + "/" + str(kill_count_requirement))

func serialize() -> Dictionary:
    var dict := super()

    dict["is_combat_quest"] = true
    dict["kill_count_requirement"] = kill_count_requirement
    dict["current_kill_count"] = current_kill_count

    return dict

func from_serialized_combat_quest(data: Dictionary) -> Combat_Quest:
    var combat_quest := Combat_Quest.new()

    combat_quest.quest_name = data.get("quest_name")
    combat_quest.quest_description = data.get("quest_description")
    combat_quest.is_active = data.get("is_active")
    combat_quest.is_finished = data.get("is_finished")
    combat_quest.kill_count_requirement = data.get("kill_count_requirement")
    combat_quest.current_kill_count = data.get("current_kill_count")

    return combat_quest