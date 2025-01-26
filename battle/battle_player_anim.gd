extends Control
class_name PlayerAnim

@onready var sprite: AnimatedSprite2D = $"Sprite"
@onready var head_atck: Sprite2D = $"HeadAttack"
@onready var head_cute: Sprite2D = $"HeadCute"
@onready var atk_breath: GPUParticles2D = $"AttackBreath"
@onready var atk_spit: GPUParticles2D = $"AttackSpit"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play()

func breath_attack()->void:
	head_cute.hide()
	head_atck.show()
	atk_breath.emitting=true
	get_tree().create_timer(1.5).timeout.connect(_stop_breath)
	
func _stop_breath()->void:
	head_cute.show()
	head_atck.hide()
	atk_breath.emitting=false

func spit_attack()->void:
	head_cute.hide()
	head_atck.show()
	atk_spit.emitting=true
	get_tree().create_timer(0.5).timeout.connect(_stop_spit)

func _stop_spit()->void:
	head_cute.show()
	head_atck.hide()
