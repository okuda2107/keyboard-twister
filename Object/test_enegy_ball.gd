extends Node2D

@onready var player_enegy_ball = preload("res://Object/PlayerEnegyBall.tscn")
@onready var enemy_enegy_ball = preload("res://Object/MonsterEnegyBall.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	test_func()
	test_func()


func test_func() -> void:
	#var enegy_ball = enemy_enegy_ball
	var enegy_ball = player_enegy_ball
	var x = randi_range(0, 1300)
	var y = randi_range(0, 700)
	print(x, ',', y)
	var eb = enegy_ball.instantiate()
	eb.point = Vector2(x, y)
	eb.from_vec = Vector2(100, 100)
	eb.to_vec = Vector2(600, 600)
	eb.speed = 1000
	add_child(eb)
	print('create')
