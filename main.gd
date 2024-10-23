extends Node2D

@onready var title = $Title
@onready var game = $Game

func _ready() -> void:
	show_title()

func show_title() -> void:
	remove_child(game)
	add_child(title)

func game_start() -> void:
	remove_child(title)
	add_child(game)
