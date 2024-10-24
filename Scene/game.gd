extends Node2D

signal prev_scene

var rng = RandomNumberGenerator.new()
signal set_key(Key)
signal failed_capture(count: int)
signal show_message(message)
signal show_result(score: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_set_key_timer_timeout()


func game_over() -> void:
	print("game over!!")

func calc_key(key) -> String:
	match key:
		KEY_A: return 'A'
		KEY_B: return 'B'
		KEY_C: return 'C'
		KEY_D: return 'D'
		KEY_E: return 'E'
		KEY_F: return 'F'
		KEY_G: return 'G'
		KEY_H: return 'H'
		KEY_I: return 'I'
		KEY_J: return 'J'
		KEY_K: return 'K'
		KEY_L: return 'L'
		KEY_M: return 'M'
		KEY_N: return 'N'
		KEY_O: return 'O'
		KEY_P: return 'P'
		KEY_Q: return 'Q'
		KEY_R: return 'R'
		KEY_S: return 'S'
		KEY_T: return 'T'
		KEY_U: return 'U'
		KEY_V: return 'V'
		KEY_W: return 'W'
		KEY_X: return 'X'
		KEY_Y: return 'Y'
		KEY_Z: return 'Z'
		_: return ''

func _input(event: InputEvent) -> void:
	if event is InputEvent:
		if event.is_action_pressed("ui_cancel"):
			prev_scene.emit()

func _on_set_key_timer_timeout() -> void:
	$SetKeyTimer.stop()
	rng.randomize()
	var random_int = rng.randi_range(0, $Player.keycode_array.size()-1)
	var key_code = $Player.keycode_array[random_int]
	var key_string = calc_key(key_code)
	show_message.emit("Press" + key_string + "!!!")
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
