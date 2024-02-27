extends CharacterBody2D

class_name Enemy_shooter

@export var AmmoPack : PackedScene
var target : Player
var speed : int = 20
var damage_to_player : int = 100
var shooting_t : Timer
var shooting_delay : float = 0.8



func _ready() -> void:
	shooting_t_setup()

func shooting_t_setup() -> void :
	shooting_t = Timer.new()
	add_child(shooting_t)
	shooting_t.one_shot = false
	shooting_t.wait_time = shooting_delay
	shooting_t.timeout.connect(shoot)
	shooting_t.start()


func shoot() -> void:
	$ShootComponent.shoot()


func _physics_process(delta: float)  -> void:
	if not target:
		target = get_tree().get_first_node_in_group("player")
	else:
		chase_player()


func chase_player() -> void:
	velocity= position.direction_to(target.position)* speed
	move_and_slide()
	look_at(target.position)


func dmg(dmg)-> void :
	$HealthComponent.take_dmg(dmg)
	update_healthbar_re()


func update_healthbar_re() -> void:
	$HealthBarComponent.update_healthbar($HealthComponent.health)

#func die() -> void:
	#var percent = randf()
	#if (percent > 0.3): drop_ammo()
	#queue_free()


#func drop_ammo() -> void:
	#var NewAmmoPack = AmmoPack.instantiate()
	#get_tree().get_first_node_in_group("Level").add_child(NewAmmoPack)
	#NewAmmoPack.global_transform = $Marker2D.global_transform


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body is Player:
		var player = body as Player
		player.dmg(damage_to_player) 
		dmg(50)

