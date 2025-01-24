extends Resource
class_name DialogNode

var _dialog_system: DialogSystem

func goto_dialog(dialog: DialogNode) -> void:
	_dialog_system.current_dialog = dialog
