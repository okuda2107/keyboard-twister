extends Node2D

@export var hp = 100
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
var current_keycode_array: Array[Key] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_keycode_array = []


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		for keycode in current_keycode_array:
			if event.keycode == keycode and event.is_released():
				current_keycode_array.clear()
				print("release!")

func append_keycode(keycode: Key) -> void:
	current_keycode_array.append(keycode)
