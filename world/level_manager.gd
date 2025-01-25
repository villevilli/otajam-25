extends Node2D
class_name LevelManager

var entrypoint: String= ""

func switch_level(level: String, spawn_pos: String) -> void:
	entrypoint=spawn_pos
	var levels: Array[Node] = find_children("","Level")
	add_child((load("res://levels/levels/"+level+".tscn") as PackedScene).instantiate())
	for lvl in levels:
		lvl.queue_free()
