extends Node2D

signal prev_scene

@onready var player_enegy_ball = preload("res://Object/PlayerEnegyBall.tscn")
@onready var enemy_enegy_ball = preload("res://Object/MonsterEnegyBall.tscn")

@export var ball_speed = 250

var rng = RandomNumberGenerator.new()
signal set_key(Key)
signal show_message(message)
signal show_result(score)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	_on_set_key_timer_timeout()
	randomize()

func _process(delta: float) -> void:
	$Hud/EnemyHP.value = float($Enemy.capture_hp) / float($Enemy.max_capture_hp) * 100
	$Hud/PlayerHP.value = float($Player.hp) / float($Player.max_hp) * 100
	if $Enemy.canAttack and not game_over_flag:
		$Hud/EnemyAnger.value = float($Enemy.hp) / float($Enemy.max_hp) * 100
	else:
		$Hud/EnemyAnger.value = 0
	$Message/Label/ProgressBar.value = $PressKeyTimer.time_left / $PressKeyTimer.wait_time * 100

func game_over() -> void:
	get_tree().paused = true
	show_result.emit($Timer.time_left)
	$BGM.stop()
	$Clear.play()
	await get_tree().create_timer(6.5).timeout
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
	while key_code in $Player.press_keycode_array:
		random_int = rng.randi_range(0, $Player.keycode_array.size()-1)
		key_code = $Player.keycode_array[random_int]
	var key_string = calc_key(key_code)
	show_message.emit("Press " + key_string + " !!!")
	set_key.emit(key_code)
	$PressKeyTimer.start()

func _on_press_key_timer_timeout() -> void:
	$Message.hide()
	enemy_attack_anim()
	_on_player_down_anim()
	var tween = get_tree().create_tween()
	tween.tween_property($Hud/PlayerHP, "value", 0, 1)
	$Player.hp = 0
	await get_tree().create_timer(2).timeout
	game_over()


func _on_player_press_key() -> void:
	$Message.hide()
	$PressKeyTimer.stop()
	$SetKeyTimer.start()


func _on_enemy_calming_down() -> void:
	$SetKeyTimer.start()


func _on_player_knock_down() -> void:
	_on_player_down_anim()
	await get_tree().create_timer(1).timeout
	game_over()


func _on_player_miss(value) -> void:
	$PressKeyTimer.stop()
	$SetKeyTimer.stop()
	$Message.hide()


func _on_player_attack_enemy(damage: int) -> void:
	if game_over_flag:
		return
	var x = randi_range(0, 1300)
	var y = randi_range(0, 700)
	var eb = player_enegy_ball.instantiate()
	eb.point = Vector2(x, y)
	eb.from_vec = $Player.position
	eb.to_vec = $Enemy.position
	eb.speed = ball_speed
	add_child(eb)


func _on_enemy_attack_player(damage: int) -> void:
	if game_over_flag:
		return
	var x = randi_range(0, 1300)
	var y = randi_range(0, 700)
	var eb = enemy_enegy_ball.instantiate()
	eb.point = Vector2(x, y)
	eb.from_vec = $Enemy.position
	eb.to_vec = $Player.position
	eb.speed = ball_speed
	add_child(eb)

func _enemy_captured() -> void:
	$SetKeyTimer.stop()
	$PressKeyTimer.stop()
	game_over()

func enemy_attack_anim() -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(_on_enemy_attack_player, 0, 0, 1)
	await get_tree().create_timer(1).timeout

var game_over_flag = false

func _on_player_down_anim() -> void:
	game_over_flag = true
	$Enemy.set_process(false)
	$Player.set_process(false)
	$Barrier.set_process(false)
	get_tree().call_group("enegy_ball", "queue_free")
	var tween = create_tween()
	tween.TRANS_ELASTIC
	tween.parallel().tween_property($Player, "position", Vector2(650, 900), 3)
	tween.play()

func _on_enemy_captured_anim() -> void:
	game_over_flag = true
	$Enemy.set_process(false)
	$Player.set_process(false)
	$Barrier.set_process(false)
	var tween = get_tree().create_tween()
	tween.tween_property($Enemy, "scale", Vector2(0, 0), 0.3)
	tween.parallel().tween_property($Barrier, "scale", Vector2(0, 0), 0.3)
	tween.play()
	$CaptureMusic.play()
	await get_tree().create_timer(1).timeout
	_enemy_captured()
