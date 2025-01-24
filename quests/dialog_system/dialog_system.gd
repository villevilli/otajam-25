extends Control
class_name DialogSystem

@export var current_dialog: DialogNode:
	set(dialog_node):
		current_dialog = dialog_node
		match typeof(dialog_node):
			StraightDialog:
				pass
			EndDialog:
				pass

@onready var simple_dialog_text: RichTextLabel = get_node("DialogPanel/SimpleDialog/HBoxContainer/ScrollContainer/MarginContainer/SimpleDialogText")
@onready var dialog_panel: Panel = get_node("%DialogPanel")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_panel.connect("gui_input", _dialog_input)
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if current_dialog is StraightDialog:
			simple_dialog_text.text = (current_dialog as StraightDialog).get_dialog_text()
	elif current_dialog is EndDialog:
			simple_dialog_text.text = (current_dialog as EndDialog).get_dialog_text()


func _dialog_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT && (event as InputEventMouseButton).is_released():
			dialog_clicked()


func dialog_clicked() -> void:
	if current_dialog is StraightDialog:
		current_dialog = (current_dialog as StraightDialog).next_dialog
	elif current_dialog is EndDialog:
		finish_dialog()

func finish_dialog() -> void:
	queue_free()
