extends CharacterBody2D

@export var speed: float = 400

func _physics_process(delta:float)->void:
	var input_direction:Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	print(position)
	move_and_slide()
