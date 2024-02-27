extends Node2D

@export var bullet_scene : PackedScene

@export var ammo : int
@export var bullet_dmg : int
@export var bullet_speed : int



func shoot() -> void:
	if ammo > 0 :
		var bullet_instance = bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.target = 1
		bullet_instance.stat_setup(bullet_dmg,bullet_speed)
		bullet_instance.global_transform = $BulletSpawnpoint.global_transform
		ammo -= 1
		
		get_tree().get_first_node_in_group("UI").ammo_update(ammo)

func add_ammo(plus_ammo) -> void :
	ammo += plus_ammo
	get_tree().get_first_node_in_group("UI").ammo_update(ammo)
