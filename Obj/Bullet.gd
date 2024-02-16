extends Area2D

class_name Bullet

var bullet_speed : int = 10
var bullet_dmg : int = 30
var target : int = 1


func _physics_process(delta: float) -> void:
	position += transform.x * bullet_speed

func _ready() -> void:
	death_timer()


func death_timer() -> void:
	var ToD= Timer.new()
	add_child(ToD)
	ToD.one_shot = 0
	ToD.wait_time = 5
	ToD.timeout.connect(die)
	ToD.start()


func die():
	queue_free()


func stat_setup(dmg : int, spd : int) -> void:
	bullet_dmg = dmg
	bullet_speed = spd


func _on_body_entered(body: Node2D) -> void:
	if target == 1:
		if body is Enemy : 
			var enemy = body as Enemy
			enemy.dmg(bullet_dmg)
			die()
		if body is Enemy_shooter : 
			var enemy = body as Enemy_shooter
			enemy.dmg(bullet_dmg)
			die()
	if target == 0:
		if body is Player:
			var player = body as Player
			player.dmg(bullet_dmg)
			die()
