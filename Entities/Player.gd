extends CharacterBody2D

class_name Player
@export var bullet : PackedScene
var mov_speed : int = 1000
var healt : int = 100
@onready var coordinates = $Spawn
var ammo : int = 50
var bullet_dmg : int = 20
var bullet_speed : int = 10


func _ready() -> void:
	$ProgressBar.value = healt
	get_tree().get_first_node_in_group("UI").ammo_update(ammo)


func _physics_process(delta: float) -> void:
	move()
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"): shoot()
	if Input.is_action_just_pressed("Esc_menu"): 
		get_tree().get_first_node_in_group("pause").pause()





func move() -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("down_go"): velocity.y += 1
	if Input.is_action_pressed("up_go"): velocity.y -= 1
	if Input.is_action_pressed("left_go"): velocity.x -= 1
	if Input.is_action_pressed("right_go"): velocity.x += 1
	velocity *= mov_speed
	move_and_slide()


func shoot() -> void:
	if ammo > 0 :
		var bullet_instance = bullet.instantiate()
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.target = 1
		bullet_instance.stat_setup(bullet_dmg,bullet_speed)
		bullet_instance.global_transform = coordinates.global_transform
		ammo -= 1
		get_tree().get_first_node_in_group("UI").ammo_update(ammo)

func dmg(dameg)-> void :
	healt = max(healt-dameg, 0)
	print(healt)
	$ProgressBar.value = healt
	if healt == 0: die()


func die():
	get_tree().get_first_node_in_group("quit").pause()
	queue_free()


func add_ammo(plus_ammo) -> void :
	ammo += plus_ammo
	var Ui_ref = get_tree().get_first_node_in_group("UI")
	Ui_ref.ammo_update(ammo)




