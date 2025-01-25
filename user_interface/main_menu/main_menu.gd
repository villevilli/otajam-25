extends Control

var file_dialog: FileDialog

func _on_new_game_pressed() -> void:
	LevelManager.levelchange.emit("example_level", "default")

func _on_close_game_button_down() -> void:
	get_tree().quit()


func _on_load_game_pressed() -> void:
	file_dialog = FileDialog.new()
	file_dialog.access = FileDialog.ACCESS_USERDATA
	file_dialog.popup_exclusive_centered(self, Vector2i(500, 500))
	file_dialog.current_path = "user://saves/"
	file_dialog.title = "Load Save"
	file_dialog.filters.append("*.json")
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.file_selected.connect(_file_selected)


func _file_selected(path: String) -> void:
	print(path)
	LevelManager.levelchange.emit("example_level", "default")
	SaveMager.load_game(path)