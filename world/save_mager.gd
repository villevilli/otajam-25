extends Node

func save_game(file_name: String) -> void:
	var json := JSON.stringify(QuestManager.serialize())
	var file := FileAccess.open("user://" + file_name + "/quests.json", FileAccess.WRITE)
	file.store_string(json)

func load_game(file_name: String) -> void:
	var file := FileAccess.open("user://" + file_name + "/quests.json", FileAccess.READ)
	var json := file.to_string()
	QuestManager.deserialize(JSON.parse_string(json))