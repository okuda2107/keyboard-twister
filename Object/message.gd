extends CanvasLayer


func _on_game_show_message(message: Variant) -> void:
	$Label.text = message
	show()
