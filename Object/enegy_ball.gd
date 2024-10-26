extends Node2D

@export var from_vec = Vector2(0, 0)
@export var to_vec = Vector2(0, 0)
var point = Vector2(0, 0)
@export var speed = 250

func _init(pos: Vector2) -> void:
	point = pos

func _ready() -> void:
	var curve = $Path2D.get_curve()
	curve.add_point(from_vec, Vector2.ZERO, point - from_vec)
	curve.add_point(to_vec, point - to_vec, Vector2.ZERO)
	$Path2D.set_curve(curve)

func _process(delta: float) -> void:
	$Path2D/PathFollow2D.progress += speed * delta
