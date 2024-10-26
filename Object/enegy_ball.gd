extends Node2D

@export var from_vec = Vector2(0, 0)
@export var to_vec = Vector2(0, 0)
var point = Vector2(0, 0)
@export var speed = 250

func _ready() -> void:
	var curve = Curve2D.new()
	curve.add_point(from_vec, Vector2.ZERO, point - from_vec)
	curve.add_point(to_vec, Vector2.ZERO, Vector2.ZERO)
	$Path2D.set_curve(curve)

func _process(delta: float) -> void:
	$Path2D/PathFollow2D.progress += speed * delta
	if $Path2D/PathFollow2D.progress_ratio == 1.0:
		$Path2D/PathFollow2D/Area2D/Bomb.show()
		$Path2D/PathFollow2D/Area2D/EnagyBall.hide()
		await get_tree().create_timer(1).timeout
		queue_free()

# うまく動かんかった．調査が必要
func _on_area_2d_body_entered(node: Node2D) -> void:
	pass
