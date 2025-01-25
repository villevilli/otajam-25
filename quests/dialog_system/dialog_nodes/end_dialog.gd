extends DialogNode
class_name EndDialog

@export_multiline var dialog_text: String

func get_dialog_text() -> String:
    return dialog_text