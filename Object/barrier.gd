extends Node2D

@export var arg_speed = 0.3
@export var tween_time = 0.5
@onready var max_alpha = $Barrier.material.get_shader_parameter("alpha")

func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.rotation += delta * arg_speed

func set_alpha(alpha: float):
	$Barrier.material.set_shader_parameter("alpha", alpha)

func _capture() -> void:
	var tween = get_tree().create_tween()
	show()
	self.scale = Vector2(50, 50)
	tween.tween_property(self, "scale", Vector2(1, 1), tween_time)
	tween.parallel().tween_method(set_alpha, 0.0, max_alpha, tween_time)
	tween.play()

func _break() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(50, 50), tween_time)
	tween.parallel().tween_method(set_alpha, max_alpha, 0.0, tween_time)
	tween.play()
	hide()

func _captured_anim() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.01)
	tween.parallel().chain().tween_property(self, "scale", Vector2(0, 0), 0.3)
	tween.play()
