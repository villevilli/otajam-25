extends Node

func _ready() -> void:
	if !DirAccess.dir_exists_absolute("user://saves/"):
		DirAccess.make_dir_absolute("user://saves/")

func save_game(file_name: String) -> void:
	var json := JSON.stringify({"quests": QuestManager.serialize()})
	var file := FileAccess.open("user://saves/" + file_name + ".json", FileAccess.WRITE)
	file.store_string(json)

func load_game(file_path: String) -> void:
	var file := FileAccess.open(file_path, FileAccess.READ)
	var json := file.to_string()
	QuestManager.deserialize(JSON.parse_string(json)["quests"])