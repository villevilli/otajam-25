extends CanvasLayer
class_name PlayerAnim

@onready var sprite: AnimatedSprite2D = $"Sprite"
@onready var head_atck: Sprite2D = $"HeadAttack"
@onready var head_cute: Sprite2D = $"HeadCute"
@onready var atk_particles_right: GPUParticles2D = $"AttackParticlesRight"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play()

func breath_attack()->void:
	head_cute.hide()
	head_atck.show()
	atk_particles_right.emitting=true
	get_tree().create_timer(2).timeout.connect(_stop_breath)
	
func _stop_breath()->void:
	head_cute.show()
	head_atck.hide()
	atk_particles_right.emitting=false
