extends CharacterBody2D

class_name Enemy

@export var AmmoPack : PackedScene
var target : Player
var healt = 30
var speed : int = 300
var damage_to_player = 20

func _ready() -> void:
	$ProgressBar_anchor/ProgressBar.max_value = healt
	$ProgressBar_anchor/ProgressBar.value = healt

func _physics_process(delta: float)  -> void:
	fix_ProgressBar_Rotation()
	if not target:
		target = get_tree().get_first_node_in_group("player")
	else:
		chase_player()



	
func chase_player() -> void:
	velocity= position.direction_to(target.position)* speed
	move_and_slide()
	look_at(target.position)


func die() -> void:
	var percent = randf()
	if (percent > 0.6): drop_ammo()
	queue_free()

func drop_ammo() -> void:
	var NewAmmoPack = AmmoPack.instantiate()
	get_tree().get_first_node_in_group("Level").add_child(NewAmmoPack)
	NewAmmoPack.global_transform = $Marker2D.global_transform


func dmg(dmg)-> void :
	healt = max(healt-dmg, 0)
	$ProgressBar_anchor/ProgressBar.value = healt
	if healt == 0:
		GameManager.enemy_death_handler()
		die()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var player = body as Player
		player.dmg(damage_to_player) 
		GameManager.enemy_death_handler()
		die()

func fix_ProgressBar_Rotation() -> void:
	$ProgressBar_anchor.set_rotation_degrees(-self.get_rotation_degrees())
