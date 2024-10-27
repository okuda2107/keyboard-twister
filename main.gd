extends Node2D

@onready var title = preload("res://Scene/Title.tscn")
@onready var game = preload("res://Scene/Game.tscn")
var cur_scene = null

func _ready() -> void:
	show_title()

func show_title() -> void:
	remove_child(cur_scene)
	cur_scene = title.instantiate()
	cur_scene.connect("next_scene", game_start)
	add_child(cur_scene)

func game_start() -> void:
	remove_child(cur_scene)
	cur_scene = game.instantiate()
	cur_scene.connect("prev_scene", show_title)
	add_child(cur_scene)
