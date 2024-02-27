extends Node2D


#updates the healthbar to the current value of health
func update_healthbar(health : int ) -> void :
	$HealthBar.value = health


#on the subj use 	self.get_rotation_degrees()		to get subj_rot
func fix_healthbar_rotation(subj_rot : int) -> void:
	self.set_rotation_degrees(-subj_rot)
