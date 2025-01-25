extends CanvasLayer
class_name DialogSystem

@export var dialog_letter_delay_ms: int = 10

var current_dialog: DialogNode:
	set(dialog_node):
		if current_dialog != null:
			current_dialog.dialog_finished()
		current_dialog = dialog_node
		_update_dialog_portrait(dialog_node.portrait)
		_reset_simple_text()

@export_category("Dialogue")
@export var start_dialog: DialogNode

@onready var simple_dialog_text: RichTextLabel = $"%SimpleDialogText"
@onready var dialog_panel: Panel = $"%DialogPanel"
@onready var character_portrait: TextureRect = $"%CharacterPortrait"

var ms_elapsed: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS

	current_dialog = start_dialog
	dialog_panel.connect("gui_input", _dialog_input)
	get_tree().paused = true

func _process(_delta: float) -> void:
	 
	ms_elapsed += int(_delta * 1000)

	if ms_elapsed >= dialog_letter_delay_ms:
		_reveal_new_letter()

	if current_dialog is StraightDialog:
			simple_dialog_text.text = (current_dialog as StraightDialog).get_dialog_text()
	elif current_dialog is EndDialog:
			simple_dialog_text.text = (current_dialog as EndDialog).get_dialog_text()


func _update_dialog_portrait(texture: Texture2D) -> void:
	character_portrait.texture = texture
	

func _dialog_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT && (event as InputEventMouseButton).is_released():
			dialog_clicked()

func _reset_simple_text() -> void:
	if simple_dialog_text == null:
		print("null")
		return
	
	simple_dialog_text.visible_characters = 0

func _reveal_new_letter() -> void:
	simple_dialog_text.visible_characters += 1

func dialog_clicked() -> void:
	current_dialog.dialog_finished()


	if current_dialog is StraightDialog:
		current_dialog = (current_dialog as StraightDialog).next_dialog
	elif current_dialog is EndDialog:
		finish_dialog()

func finish_dialog() -> void:
	get_tree().paused = false
	queue_free()
