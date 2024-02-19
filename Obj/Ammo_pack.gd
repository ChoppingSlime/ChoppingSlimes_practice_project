extends Area2D
var ammo : int = 10


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player = body as Player
		player.add_ammo(ammo) 
		queue_free()
