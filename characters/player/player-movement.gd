extends CharacterBody2D
class_name Player

@export var speed: float = 500
@onready var sprite: AnimatedSprite2D = $"Sprite"
@onready var head_atck: Sprite2D = $"HeadAttack"
@onready var head_cute: Sprite2D = $"HeadCute"
@onready var atk_particles_right: GPUParticles2D = $"AttackParticlesRight"
@onready var atk_particles_left: GPUParticles2D = $"AttackParticlesLeft"

func _ready() -> void:
	sprite.play()
	
func _process(_delta: float) -> void:
	var attacking: bool = Input.is_action_pressed("attack")
	if attacking:
		head_atck.show()
		head_cute.hide()
		if head_atck.flip_h:
			atk_particles_right.emitting=true
		else:
			atk_particles_left.emitting=true
	else:
		head_atck.hide()
		head_cute.show()
		atk_particles_left.emitting=false
		atk_particles_right.emitting=false

func _physics_process(_delta: float) -> void:
	#var input_direction:Vector2 = Input.get_vector("left", "right", "up", "down")
	var input_x: float = Input.get_axis("left", "right")
	var input_y: float = Input.get_axis("up", "down")
	var input_direction: Vector2 = Vector2(input_x, input_y)
	velocity = input_direction * speed
	
	if input_x < 0:
		sprite.flip_h = false
		head_atck.flip_h = false
		head_cute.flip_h = false
		atk_particles_left.emitting=false
		atk_particles_right.emitting=false
	if input_x > 0:
		sprite.flip_h = true
		head_atck.flip_h = true
		head_cute.flip_h = true
		atk_particles_right.emitting=false
		atk_particles_left.emitting=false
	move_and_slide()
