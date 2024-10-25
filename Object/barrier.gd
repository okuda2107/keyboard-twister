extends Node2D

@export var arg_speed = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.rotation += delta * arg_speed

func _capture() -> void:
	pass
