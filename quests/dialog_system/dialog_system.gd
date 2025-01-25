extends Control
class_name DialogSystem

@export var dialog_letter_delay_ms: int = 10

var current_dialog: DialogNode:
	set(dialog_node):
		current_dialog = dialog_node
		_reset_simple_text()

@export var start_dialog: DialogNode

@onready var simple_dialog_text: RichTextLabel = $"%SimpleDialogText"
@onready var dialog_panel: Panel = $"%DialogPanel"

var ms_elapsed: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_dialog = start_dialog
	dialog_panel.connect("gui_input", _dialog_input)
	pass # Replace with function body.

func _process(_delta: float) -> void:
	 
	ms_elapsed += int(_delta * 1000)

	if ms_elapsed >= dialog_letter_delay_ms:
		_reveal_new_letter()

	if current_dialog is StraightDialog:
			simple_dialog_text.text = (current_dialog as StraightDialog).get_dialog_text()
	elif current_dialog is EndDialog:
			simple_dialog_text.text = (current_dialog as EndDialog).get_dialog_text()


func _dialog_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT && (event as InputEventMouseButton).is_released():
			dialog_clicked()

func _reset_simple_text() -> void:
	if simple_dialog_text == null:
		print("null")
		return

	if simple_dialog_text.visible_ratio >= 1:
		return
	
	simple_dialog_text.visible_characters = 0

func _reveal_new_letter() -> void:
	simple_dialog_text.visible_characters += 1

func dialog_clicked() -> void:
	if current_dialog is StraightDialog:
		current_dialog = (current_dialog as StraightDialog).next_dialog
	elif current_dialog is EndDialog:
		finish_dialog()

func finish_dialog() -> void:
	queue_free()
