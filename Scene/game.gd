extends Node2D

signal prev_scene

var rng = RandomNumberGenerator.new()
signal set_key(Key)
signal failed_capture(count: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_set_key_timer_timeout()


func game_over() -> void:
	print("game over!!")

# なんのキーを押さなあかんか通知する
func show_press_key(key: Key) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEvent:
		if event.is_action_pressed("ui_cancel"):
			prev_scene.emit()

func _on_set_key_timer_timeout() -> void:
	$SetKeyTimer.stop()
	rng.randomize()
	var random_int = rng.randi_range(0, $Player.keycode_array.size()-1)
	var key_code = $Player.keycode_array[random_int]
	show_press_key(key_code)
	set_key.emit(key_code)
	$PressKeyTimer.start()

func _on_press_key_timer_timeout() -> void:
	game_over()


func _on_player_press_key() -> void:
	$PressKeyTimer.stop()
	$SetKeyTimer.start()


func _on_player_release_keys() -> void:
	$PressKeyTimer.stop()
	$SetKeyTimer.stop()
	failed_capture.emit()


func _on_enemy_calming_down() -> void:
	_on_set_key_timer_timeout()


func _on_player_knock_down() -> void:
	game_over()
