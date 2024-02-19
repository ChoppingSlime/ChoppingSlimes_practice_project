extends CharacterBody2D

class_name Enemy_shooter

@export var bullet : PackedScene
@export var AmmoPack : PackedScene
var target : Player
var healt : int = 90
var speed : int = 20
var damage_to_player : int = 100
var shooting_t : Timer
var shooting_delay : float = 0.8
var bullet_dmg : int = 10
var bullet_speed : int = 10
@onready var coordinates = $Spawn


func _ready() -> void:
	$ProgressBar_anchor/ProgressBar.max_value = healt
	$ProgressBar_anchor/ProgressBar.value = healt
	shooting_t_setup()

func shooting_t_setup() -> void :
	shooting_t = Timer.new()
	add_child(shooting_t)
	shooting_t.one_shot = false
	shooting_t.wait_time = shooting_delay
	shooting_t.timeout.connect(shoot)
	shooting_t.start()


func shoot() -> void:
	var bullet_instance = bullet.instantiate()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.target = 0
	bullet_instance.stat_setup(bullet_dmg,bullet_speed)
	bullet_instance.global_transform = coordinates.global_transform



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


func dmg(dmg)-> void :
	healt = max(healt-dmg, 0)
	$ProgressBar_anchor/ProgressBar.value = healt
	if healt == 0:
		GameManager.enemy_death_handler()
		die()


func die() -> void:
	var percent = randf()
	if (percent > 0.3): drop_ammo()
	queue_free()


func drop_ammo() -> void:
	var NewAmmoPack = AmmoPack.instantiate()
	get_tree().get_first_node_in_group("Level").add_child(NewAmmoPack)
	NewAmmoPack.global_transform = $Marker2D.global_transform


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body is Player:
		var player = body as Player
		player.dmg(damage_to_player) 
		GameManager.enemy_death_handler()
		die()


func fix_ProgressBar_Rotation() -> void:
	$ProgressBar_anchor.set_rotation_degrees(-self.get_rotation_degrees())
