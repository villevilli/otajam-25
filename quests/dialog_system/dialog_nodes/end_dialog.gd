extends DialogNode
class_name EndDialog

@export_multiline var dialog_text: String
@export var quest: Quest

func get_dialog_text() -> String:
    return dialog_text

func dialog_finished() -> void:
    super()
    QuestManager.quest_started.emit(quest)