extends CharacterBody2D

class_name Enemy

@export var AmmoPack : PackedScene
var target : Player
var speed : int = 300
var damage_to_player = 20


func _physics_process(delta: float)  -> void:
	if not target:
		target = get_tree().get_first_node_in_group("player")
	else:
		chase_player()


func chase_player() -> void:
	velocity= position.direction_to(target.position)* speed
	move_and_slide()
	look_at(target.position)


func drop_ammo() -> void:
	var NewAmmoPack = AmmoPack.instantiate()
	get_tree().get_first_node_in_group("Level").add_child(NewAmmoPack)
	NewAmmoPack.global_transform = $Marker2D.global_transform


func dmg(dmg)-> void :
	$HealthComponent.take_dmg(dmg)
	update_healthbar_re()
	

func update_healthbar_re() -> void:
	$HealthBarComponent.update_healthbar($HealthComponent.health)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var player = body as Player
		player.dmg(damage_to_player) 
		GameManager.enemy_death_handler()
		dmg(40)


