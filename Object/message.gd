extends CanvasLayer


func _on_game_show_message(message: Variant) -> void:
	$result.hide()
	$Label/Label.text = message
	$Label.show()
	show()


func _on_game_show_result(score) -> bool:
	$Label.hide()
	$Control/Label2.text = "%10.1f" % score
	show()
	$Control.show()
	await get_tree().create_timer(3).timeout
	$Control.hide()
	$result.show()
	await get_tree().create_timer(3).timeout
	return true


func _on_game_show_remain_hp(hp: Variant) -> void:
	$Label.hide()
	$Control/Label.text = "Remain HP"
	$Control/Label2.text = '%10d' % hp + '%'
	show()
	$Control.show()
	await get_tree().create_timer(3).timeout
	$Control.hide()
	$result.show()
	await get_tree().create_timer(3).timeout
