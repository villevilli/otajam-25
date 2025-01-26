extends Control

@onready var attack_breath_button: Button = $"PlayerActions/BreathAttack"

# Animations
@onready var player_anim: PlayerAnim = $"PlayerAnim"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_breath_button.pressed.connect(_breath_attack)

func _breath_attack()->void:
	player_anim.breath_attack()
	
