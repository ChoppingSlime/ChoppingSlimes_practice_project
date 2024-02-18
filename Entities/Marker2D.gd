extends Marker2D
var rotation_player
var desired_rotation = 0


func _physics_process(delta: float) -> void:
	rotation_player = get_tree().get_first_node_in_group("player").get_rotation_degrees()

	#print(rotation_sus)
	set_rotation_degrees(-rotation_player)


 
	
