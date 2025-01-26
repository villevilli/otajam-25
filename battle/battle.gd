extends Panel

var player_max_health: int = 50
var player_health: int = 50
var enemy_max_health: int = 50
var enemy_health: int = 50


#Player Actions



# UI Display
@onready var player_healthbar: TextureProgressBar = $"PlayerHealth/TextureProgressBar"
@onready var enemy_healthbar: TextureProgressBar = $"EnemyHealth/TextureProgressBar" 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	
	enemy_healthbar.max_value=enemy_max_health
	player_healthbar.max_value=player_max_health
	enemy_healthbar.value=enemy_health
	player_healthbar.value=player_health


func _player_breath_attack()->void:
		player_anim.breath_attack()
		_damage_enemy(5)
	
func _damage_enemy(amount: int)->void:
	enemy_health-=amount
	enemy_healthbar.value=enemy_health
	
