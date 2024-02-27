extends Node2D

@export var health : int
@onready var maxhealth = health

func die() -> void :
	#if not enemy
	if get_parent().has_method("die"):
		get_parent().die()
		
	#if enemy
	else:
		gamemanager_notifier()
		get_parent().queue_free()

#takes damage. if dmg>health, dies
func take_dmg(dmg)-> void :
	health = max(health - dmg, 0)
	if health == 0: die()

func heal(heal) -> void :
	health = min(health+ heal, maxhealth)

func gamemanager_notifier() ->void :
	GameManager.enemy_death_handler()
