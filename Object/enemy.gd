extends Node2D

@export var max_hp = 100
@export var damage = 10
@export var max_capture_hp = 100
@onready var canAttack: bool = false
signal attack_player(damage: int)
signal calming_down
signal captured

@onready var hp = max_hp
@onready var capture_hp = max_capture_hp


func _process(delta: float) -> void:
	if canAttack:
		attack_player.emit(delta * damage)
	if hp <= 0:
		hp = max_hp
		canAttack = false
		calming_down.emit()

func _on_game_failed_capture(count: int) -> void:
	canAttack = true


func _on_player_attack_enemy(damage: int) -> void:
	hp -= damage

func _on_capture_process(value) -> void:
	capture_hp -= value
	if capture_hp <= 0:
		captured.emit()
