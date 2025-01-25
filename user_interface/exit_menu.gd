extends VBoxContainer

@onready var exit_button: Button = $"%ExitButton"
@onready var save_button: Button = $"%SaveButton"
var file_dialog: FileDialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_button.pressed.connect(exit_button_pressed)
	save_button.pressed.connect(save_button_pressed)


func exit_button_pressed() -> void:
	get_tree().quit()


func save_button_pressed() -> void:
	file_dialog = FileDialog.new()
	file_dialog.process_mode = Node.PROCESS_MODE_ALWAYS
	file_dialog.access = FileDialog.ACCESS_USERDATA
	file_dialog.popup_exclusive_centered(self, Vector2i(500, 500))
	file_dialog.current_path = "user://saves/"
	file_dialog.title = "Save Game"
	file_dialog.filters.append("*.json")
	file_dialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
	file_dialog.file_selected.connect(_file_selected)


func _file_selected(path: String) -> void:
	SaveMager.save_game(path)
