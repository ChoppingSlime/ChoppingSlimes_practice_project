extends CanvasLayer

func _ready() -> void:
	hide()

func _on_quit_pressed() -> void:
	get_tree().quit()

func pause() -> void :
		get_tree().paused = true
		show()

