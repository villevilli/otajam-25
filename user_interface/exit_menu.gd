extends Control

@onready var exit_button: Button = $"ExitButton"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_button.pressed.connect(exit_button_pressed)


func exit_button_pressed() -> void:
	get_tree().quit()
