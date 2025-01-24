extends Camera2D

# Target node the camera is following
var TargetNode : Node2D = null

func _ready() -> void:
	TargetNode=get_node("../Player")

func _process(_delta:float) -> void:
	if TargetNode!=null:
		set_position(TargetNode.get_position())		
