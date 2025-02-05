extends Control
class_name BattleEnemy

@onready var battle_manager: BattleManager = $".."
@onready var enemy_healthbar: TextureProgressBar = $"EnemyHealth/TextureProgressBar" 

# Animations
@onready var particles: GPUParticles2D = $"AttackParticles"
@onready var sprite: AnimatedSprite2D = $"AiEnemy"
@onready var turn_ind: AnimatedSprite2D = $"TurnInd"

var random: RandomNumberGenerator = RandomNumberGenerator.new()

var max_health: int = 25
var health: int = max_health

func _ready() -> void:
	battle_manager.DamageEnemy.connect(_take_damage)
	battle_manager.EnemyTurn.connect(_enemy_turn)
	turn_ind.play("default")
	_update_health()
# Called when the node enters the scene tree for the first time.

func _take_damage(amount: int) -> void:
	health-=amount
	_update_health()

func _enemy_turn() -> void:
	turn_ind.show()
	print("Enemy Playing Turn")
	get_tree().create_timer(3).timeout.connect(_base_attack)
	get_tree().create_timer(4.3).timeout.connect(_yield_turn)
	
func _yield_turn()->void:
	turn_ind.hide()
	battle_manager.PlayerTurn.emit()
	
func _update_health() -> void:
	enemy_healthbar.max_value=max_health
	enemy_healthbar.value=health
	if health<=0:
		_die()
	
func _base_attack()->void:
	var damage: int = 3+ random.randi()%4
	battle_manager.DamagePlayer.emit(damage)
	sprite.play("attack")
	particles.emitting=true
	
	
func _die()->void:
	battle_manager.EnemyDefeated.emit()
