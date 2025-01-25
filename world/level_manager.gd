extends Node

var entrypoint: String= ""

signal levelchange(level: Level,spawn_pos: String)
func _ready() -> void:
	levelchange.connect(_switch_level,CONNECT_DEFERRED)

func _switch_level(level: String, spawn_pos: String) -> void:
	var new_scene: String = "res://levels/levels/"+level+".tscn"
	entrypoint=spawn_pos
	get_tree().change_scene_to_file(new_scene)
