extends Resource
class_name DialogNode

@export var portrait: Texture2D

var _dialog_system: DialogSystem

func goto_dialog(dialog: DialogNode) -> void:
	_dialog_system.current_dialog = dialog

func dialog_finished() -> void:
	pass