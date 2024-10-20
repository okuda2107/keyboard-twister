extends CanvasLayer

signal next_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Messageとかの初期化をしやなあかんかも
	# tweenの作成
	var tween = get_tree().create_tween()
	# 1秒かけて透明にする
	tween.tween_property($Button, "modulate", Color(1,1,1,0), 1).set_trans(Tween.TRANS_CUBIC)
	# 1秒かけて不透明にする
	tween.tween_property($Button, "modulate", Color(1,1,1,1), 1).set_trans(Tween.TRANS_CUBIC)
	# アニメーションを繰り返す設定
	tween.set_loops()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	show_count()

func _input(event: InputEvent) -> void:
	if event is InputEvent:
		if event.is_pressed():
			show_count()

func show_count() -> void:
	$Title.hide()
	$Button.hide()
	
	for i in range(3, 0, -1):
		$Message.text = str(i)
		$Message.show()
		await get_tree().create_timer(1.0).timeout
	
	$Message.text = "Go !!!"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	next_scene.emit()

func show_message(text):
	$Message.text = text
	$Message.show()
	
