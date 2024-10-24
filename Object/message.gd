extends CanvasLayer


func _on_game_show_message(message: Variant) -> void:
	$result.hide()
	$Label.text = message
	$Label.show()
	show()


func _on_game_show_result(score: int) -> void:
	$Label.hide()
	$result/Label2.text = str(score)
	$result.show()
	show()
