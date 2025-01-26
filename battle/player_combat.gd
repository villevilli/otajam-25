extends Control
class_name BattlePlayer

var spit_unlock_quest: StringName = "ReturnToChararas"

var max_health: int = 25
var health: int = max_health
var spit_cooldown: int = 0

@onready var battle_manager: BattleManager = $".."
var random: RandomNumberGenerator = RandomNumberGenerator.new()

#UI Input
@onready var attack_breath_button: Button = $"PlayerActions/BreathAttack"
@onready var attack_spit_button: Button = $"PlayerActions/SpitAttack"

# UI Display
@onready var player_healthbar: TextureProgressBar = $"PlayerHealth/TextureProgressBar"
@onready var player_anim: PlayerAnim = $"PlayerAnim"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Connections
	battle_manager.PlayerTurn.connect(unlock_abilities)
	battle_manager.DamagePlayer.connect(_take_damage)
	attack_breath_button.pressed.connect(_breath_attack)
	attack_spit_button.pressed.connect(_spit_attack)
	#Setup
	_setup_spit_attack()
	_update_health()
	
func _take_damage(amount: int)->void:
	health-=amount
	_update_health()
	if health<0:
		battle_manager.PlayerDefeated.emit()

func _breath_attack()->void:
	yield_turn()
	player_anim.breath_attack()
	var damage: int = 4 + random.randi()%4
	battle_manager.DamageEnemy.emit(damage)

# Spit has cooldown but deals more damage and hurts injured opponents even more.
func _spit_attack()->void:
	spit_cooldown=3
	yield_turn()
	player_anim.spit_attack()
	print(battle_manager.get_enemy_health_fraction())
	var enemy_hurt_bonus: int = clamp(round(3.0/battle_manager.get_enemy_health_fraction()),2,10)
	print(enemy_hurt_bonus)
	var damage: int = 5 + random.randi() % 2 + enemy_hurt_bonus
	battle_manager.DamageEnemy.emit(damage)

func yield_turn()->void:
	lock_abilities()
	battle_manager.EnemyTurn.emit()
	
func _update_health() -> void:
	player_healthbar.max_value=max_health
	player_healthbar.value=health

func lock_abilities() -> void:
	attack_breath_button.disabled=true
	attack_spit_button.disabled=true
	

func unlock_abilities() -> void:
	attack_breath_button.disabled=false
	spit_cooldown-=1
	if spit_cooldown<1:
		attack_spit_button.disabled=false

func _setup_spit_attack() -> void:
	attack_spit_button.hide()
	if spit_unlock_quest=="":
		attack_spit_button.show()
	var spit_quest: Quest = QuestManager.get_quest_by_name(spit_unlock_quest)
	print(spit_quest)
	if spit_quest!=null:
		if spit_quest.is_finished:
			attack_spit_button.show()
