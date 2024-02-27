extends CharacterBody2D

class_name Player

var mov_speed : int = 1000

func _ready() -> void:
	update_healthbar_re()
	get_tree().get_first_node_in_group("UI").ammo_update($ShootComponent.ammo)

func _physics_process(delta: float) -> void:
	move()
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"): 
		$ShootComponent.shoot()
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


func dmg(dmg)-> void :
	$HealthComponent.take_dmg(dmg)
	update_healthbar_re()
	

func update_healthbar_re() -> void:
	$HealthBarComponent.update_healthbar($HealthComponent.health)


func die():
	get_tree().get_first_node_in_group("quit").pause()
	queue_free()


func add_ammo(plus_ammo) -> void :
	$ShootComponent.add_ammo(plus_ammo)

