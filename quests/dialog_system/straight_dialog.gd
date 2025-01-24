extends DialogNode
class_name StraightDialog

@export_multiline var dialog_text: String
@export var next_dialog: DialogNode


func get_dialog_text() -> String:
    return dialog_text