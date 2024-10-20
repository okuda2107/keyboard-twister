extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_title()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_title() -> void:
	$Game.hide()
	$Game.get_tree().paused = true
	$Title.get_tree().paused = false
	$Title._ready()
	$Title.show()

func game_start() -> void:
	$Title.hide()
	$Title.get_tree().paused = true
	$Game.get_tree().paused = false
	$Game._ready()
	$Game.show()

func show_result() -> void:
	print("show result")
