extends Node2D

signal prev_scene

@onready var player_enegy_ball = preload("res://Object/PlayerEnegyBall.tscn")
@onready var enemy_enegy_ball = preload("res://Object/MonsterEnegyBall.tscn")

@export var ball_speed = 250

var rng = RandomNumberGenerator.new()
signal set_key(Key)
signal failed_capture(count: int)
signal show_message(message)
signal show_result(score: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_set_key_timer_timeout()
	randomize()

func game_over() -> void:
	self.set_process(false)
	show_result.emit(1)
	await get_tree().create_timer(3).timeout
	prev_scene.emit()

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
	show_message.emit("Press " + key_string + " !!!")
	set_key.emit(key_code)
	$PressKeyTimer.start()

func _on_press_key_timer_timeout() -> void:
	game_over()


func _on_player_press_key() -> void:
	$Message.hide()
	$PressKeyTimer.stop()
	$SetKeyTimer.start()


func _on_enemy_calming_down() -> void:
	$SetKeyTimer.start()


func _on_player_knock_down() -> void:
	game_over()


func _on_player_miss() -> void:
	$PressKeyTimer.stop()
	$SetKeyTimer.stop()
	$Message.hide()
	failed_capture.emit(1)


func _on_player_attack_enemy(damage: int) -> void:
	randomize()
	var x = randi_range(0, 1300)
	var y = randi_range(0, 700)
	var eb = player_enegy_ball.instantiate()
	eb.point = Vector2(x, y)
	eb.from_vec = $Player.position
	eb.to_vec = $Enemy.position
	eb.speed = ball_speed
	add_child(eb)


func _on_enemy_attack_player(damage: int) -> void:
	randomize()
	var x = randi_range(0, 1300)
	var y = randi_range(0, 700)
	var eb = enemy_enegy_ball.instantiate()
	eb.point = Vector2(x, y)
	eb.from_vec = $Enemy.position
	eb.to_vec = $Player.position
	eb.speed = ball_speed
	add_child(eb)
