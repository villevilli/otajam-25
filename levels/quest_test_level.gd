extends Node

@export var beautiful_quest: Quest

var quest_not_started := true
var elapsed_time := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta

	if elapsed_time > 0 && quest_not_started:
		beautiful_quest.start()
		quest_not_started = false
