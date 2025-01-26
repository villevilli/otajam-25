extends Control

@onready var battle_manager: BattleManager = $".."

var last_announce: int = -1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	battle_manager.DamageEnemy.connect(_announce_damage_enemy)
	battle_manager.DamagePlayer.connect(_announce_damage_player)
	battle_manager.EnemyDefeated.connect(_announce_win)

func _announce_damage_enemy(amount: int)-> void:
	_create_announcement("You attack for "+ str(amount) +" damage!")
func _announce_damage_player(amount: int)-> void:
	_create_announcement("The AI attacks you dealing "+ str(amount) +" damage!")
func _announce_win()-> void:
	print("Won Battle")
	_create_announcement("You have defeated the AI")

func _create_announcement(text: String) -> void:
	var announce_gap: int = Time.get_ticks_msec()-last_announce
	var y_offset: int = max(0,(2000-announce_gap)/20)*-1
	print("Announced: "+text)
	var announcement: Announcement = (load("res://battle/announcement/Announcement.tscn") as PackedScene).instantiate()
	announcement.text=text
	announcement.position.y+=y_offset
	add_child(announcement)
	last_announce=Time.get_ticks_msec()
