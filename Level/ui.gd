extends CanvasLayer

func wave_update(wave) -> void:
	$ColorRect/HBoxContainer2/wave_label.text = str(wave)


func ammo_update(ammo) -> void:
	$ColorRect/HBoxContainer/ammo_label.text = str(ammo)
	if (ammo < 10) :
		$ColorRect/HBoxContainer/ammo_label.label_settings.set_font_color(Color.RED)
	else:
		$ColorRect/HBoxContainer/ammo_label.label_settings.set_font_color(Color.WHITE)


func enemy_left_update(enemy) -> void:
	$ColorRect/HBoxContainer3/Enemy_left_label.text = str(enemy)
