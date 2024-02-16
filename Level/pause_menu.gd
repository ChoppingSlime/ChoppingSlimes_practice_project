extends CanvasLayer
@export var MainMenu : PackedScene

func _ready() -> void:
	hide()

func _on_pause_pressed() -> void:
	unpause()

func _on_quit_pressed() -> void:
	get_tree().quit()

func pause() -> void :
		get_tree().paused = true
		show()

func unpause() -> void :
	get_tree().paused = false
	hide()
