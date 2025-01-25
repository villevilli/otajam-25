extends DialogNode
class_name EndDialog

@export_multiline var dialog_text: String
@export var start_quest: Quest
@export var finish_quest_name: StringName

func get_dialog_text() -> String:
    return dialog_text

func dialog_finished() -> void:
    super()

    if finish_quest_name != null:
        var quest := QuestManager.get_quest_by_name(finish_quest_name)

        if quest != null: quest.complete()

    if start_quest != null:
        start_quest.start()
