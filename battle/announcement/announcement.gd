extends RichTextLabel
class_name Announcement

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_timer(2).timeout.connect(_close)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position+=Vector2(0,-2)
	modulate.a-=0.01

func _close()->void:
	queue_free()
	
	
	
