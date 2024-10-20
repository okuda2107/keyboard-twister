extends Node2D

var rng = RandomNumberGenerator.new()
signal set_key(Key)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SetKeyTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over() -> void:
	pass

func _on_set_key_timer_timeout() -> void:
	rng.randomize()
	var randi = rng.randi_range(0, $Player.keycode_array.size()-1)
	var key_code = $Player.keycode_array[randi]
	$SetKeyTimer.stop()
	set_key.emit(key_code)
