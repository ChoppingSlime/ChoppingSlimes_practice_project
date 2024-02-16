extends Node

@onready var enemy_scene = load("res://Entities/Enemy.tscn")
@onready var enemy_shooter_scene = load("res://Entities/enemy_shooter.tscn")
var wave : int = 1
var enemies_remaining : int = 2
var spawn_count : int = 0
var spawn_point : Array[Node] = []
var level : Node
var spawn_timer : Timer
var spawn_delay : float = 1.0
var enemy_shooter_chanche : float = 0.0
var enemy_instance
var current_scene 

func start_game() -> void:
	level = get_tree().get_first_node_in_group("Level")
	spawn_point = level.get_tree().get_nodes_in_group("Spawnpoint")
	get_tree().get_first_node_in_group("UI").wave_update(wave)
	get_tree().get_first_node_in_group("UI").enemy_left_update(enemies_remaining)
	spawn_timer_init()
	next_wave_handler()


func spawn_timer_init() -> void:
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.one_shot = false
	spawn_timer.wait_time = spawn_delay
	spawn_timer.timeout.connect(spawn_enemy)
	

func next_wave_handler() -> void :
	spawn_count = 0
	enemy_shooter_chanche += 0.1
	spawn_timer.start()
	

func spawn_enemy()-> void :
	var random_spawnpoint = spawn_point[randi_range(0,spawn_point.size() - 1)]
	rand_enemy()
	level.add_child(enemy_instance)
	enemy_instance.global_position = random_spawnpoint.global_position
	spawn_count += 1
	if spawn_count == wave * 2 :
		spawn_timer.stop()


func rand_enemy() -> void :
	var chanche = randf()
	if (chanche > enemy_shooter_chanche): 
		enemy_instance = enemy_scene.instantiate()
	else:
		enemy_instance = enemy_shooter_scene.instantiate()


func enemy_death_handler() -> void :
	enemies_remaining -= 1
	get_tree().get_first_node_in_group("UI").enemy_left_update(enemies_remaining)
	if enemies_remaining == 0 :
		wave += 1
		get_tree().get_first_node_in_group("UI").wave_update(wave)
		enemies_remaining = wave * 2
		get_tree().get_first_node_in_group("UI").enemy_left_update(enemies_remaining)
		next_wave_handler()


