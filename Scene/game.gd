extends Node2D

signal prev_scene

var rng = RandomNumberGenerator.new()
signal set_key(Key)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SetKeyTimer.start()


func game_over() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEvent:
		if event.is_action_pressed("ui_cancel"):
			prev_scene.emit()

func _on_set_key_timer_timeout() -> void:
	rng.randomize()
	var random_int = rng.randi_range(0, $Player.keycode_array.size()-1)
	var key_code = $Player.keycode_array[random_int]
	$SetKeyTimer.stop()
	set_key.emit(key_code)
