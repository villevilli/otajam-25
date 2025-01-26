extends Control

var max_health: int = 25
var health: int = max_health

@onready var battle_manager: BattleManager = $".."
var random: RandomNumberGenerator = RandomNumberGenerator.new()

#UI Input
@onready var attack_breath_button: Button = $"PlayerActions/BreathAttack"

# UI Display
@onready var player_healthbar: TextureProgressBar = $"PlayerHealth/TextureProgressBar"
@onready var player_anim: PlayerAnim = $"PlayerAnim"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	battle_manager.PlayerTurn.connect(unlock_abilities)
	battle_manager.DamagePlayer.connect(_take_damage)
	attack_breath_button.pressed.connect(_breath_attack)
	_update_health()
	
func _take_damage(amount: int)->void:
	health-=amount
	_update_health()

func _breath_attack()->void:
	yield_turn()
	player_anim.breath_attack()
	var damage: int = 5+ random.randi()%5
	battle_manager.DamageEnemy.emit(damage)

func yield_turn()->void:
	lock_abilities()
	battle_manager.EnemyTurn.emit()
	
func _update_health() -> void:
	player_healthbar.max_value=max_health
	player_healthbar.value=health

func lock_abilities() -> void:
	attack_breath_button.disabled=true

func unlock_abilities() -> void:
	attack_breath_button.disabled=false
