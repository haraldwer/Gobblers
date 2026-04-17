extends AnimatedSprite3D

var player: Node3D

func _process(delta: float) -> void:
	if not player:
		player = get_tree().get_nodes_in_group("Player")[0]
	var p = player.global_position;
	p.y = global_position.y;
	look_at(p)
	pass
