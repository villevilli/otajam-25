extends CharacterBody2D
class_name Player

@export var speed: float = 500
@onready var sprite: AnimatedSprite2D = $"Sprite"

func _ready() -> void:
	sprite.play()

func _physics_process(_delta: float) -> void:
	#var input_direction:Vector2 = Input.get_vector("left", "right", "up", "down")
	var input_x: float = Input.get_axis("left", "right")
	var input_y: float = Input.get_axis("up", "down")
	var input_direction: Vector2 = Vector2(input_x, input_y)
	velocity = input_direction * speed
	
	if input_x < 0:
		sprite.flip_h = false
	if input_x > 0:
		sprite.flip_h = true
	move_and_slide()
