extends Node2D

@export var hp = 100
@export var damage = 1
@export var capture_value = 1
const keycode_array: Array[Key] = [
	KEY_A,
	KEY_B,
	KEY_C,
	KEY_D,
	KEY_E,
	KEY_F,
	KEY_G,
	KEY_H,
	KEY_I,
	KEY_J,
	KEY_K,
	KEY_L,
	KEY_M,
	KEY_N,
	KEY_O,
	KEY_P,
	KEY_Q,
	KEY_R,
	KEY_S,
	KEY_T,
	KEY_U,
	KEY_V,
	KEY_W,
	KEY_X,
	KEY_Y,
	KEY_Z,
]
var press_keycode_array: Array[Key] = []
var press_keycode: Key
var is_attack_mode = false
signal press_key
signal miss
signal attack_enemy(damage: int)
signal knock_down
signal first_capture
signal capturing(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	press_keycode_array = []

func _process(delta: float) -> void:
	if capture_flag:
		capturing.emit(capture_value * press_keycode_array.size() * delta)

# もっといいやり方ないかな？
var flag = true
var capture_flag = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		for keycode in press_keycode_array:
			if event.keycode == keycode and event.is_released():
				miss_press()
			else:
				capture_flag = true
		if event.is_pressed():
			if event.keycode == press_keycode and flag:
				flag = false
				press_keycode_array.append(press_keycode)
				if press_keycode_array.size() == 1:
					first_capture.emit()
				press_key.emit()
				print(press_keycode_array)
			elif not event.keycode in press_keycode_array and flag:
				print('miss')
		if event.is_pressed() and is_attack_mode:
			attack_enemy.emit(damage)


func miss_press() -> void:
	flag = false
	capture_flag = false
	press_keycode_array.clear()
	miss.emit()

func receive_keycode(keycode: Key) -> void:
	flag = true
	press_keycode = keycode


func _on_enemy_attack_player(damage: float) -> void:
	hp -= damage
	print(str(hp))
	if hp <= 0:
		knock_down.emit()


func _on_game_failed_capture(count: int) -> void:
	is_attack_mode = true


func _on_enemy_calming_down() -> void:
	is_attack_mode = false
