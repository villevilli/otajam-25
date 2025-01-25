extends Control

func _on_new_game_pressed() -> void:
	LevelManager.levelchange.emit("example_level","default")

func _on_close_game_button_down() -> void:
	get_tree().quit()
