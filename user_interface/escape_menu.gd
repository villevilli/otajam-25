extends Control

var is_open := false

func _ready() -> void:
	visible = is_open

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		toggle_menu()


func toggle_menu() -> void:
	is_open = !is_open

	if is_open:
		close_menu()
	else:
		open_menu()


func open_menu() -> void:
	visible = true
	get_tree().paused = true


func close_menu() -> void:
	visible = false
	get_tree().paused = false