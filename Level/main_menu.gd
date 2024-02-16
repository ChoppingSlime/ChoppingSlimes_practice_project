extends Control
@export var FirstLevel : PackedScene
@export var Debuglevel : PackedScene

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(FirstLevel)


func _on_quit_button_pressed() -> void:
	get_tree().quit() 


func _on_debug_level_pressed() -> void:
	get_tree().change_scene_to_packed(Debuglevel)
