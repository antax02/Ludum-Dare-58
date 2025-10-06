extends PathFollow2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		var boss = get_tree().get_first_node_in_group("boss")
		boss.take_damage(area.damage)
		area.queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(40)
