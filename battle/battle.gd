extends Panel
class_name BattleManager

signal DamageEnemy(amount: int)
signal DamagePlayer(amount: int)
signal EnemyTurn
signal PlayerTurn
signal EnemyDefeated
signal PlayerDefeated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Battle Ready")
	print(get_node("Player").get_children())
	EnemyTurn.connect(_enemy_turn)
	PlayerTurn.connect(_player_turn)
	
	EnemyDefeated.connect(_win)
	PlayerDefeated.connect(_lose)
	
func _enemy_turn()->void:
	print("Enemy Turn")

func _player_turn()->void:
	print("Player Turn")
	
func _win()->void:
	get_tree().create_timer(2).timeout.connect(_exit_battle)

func _lose()->void:
	print("loser lmao")
	get_tree().quit()
	
func _exit_battle()-> void:
	(get_parent().get_parent() as Level).resume_game()
