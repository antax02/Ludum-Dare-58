extends Area2D


var damage: int
var target_group
var ignore_user

func _on_body_entered(body: Node2D) -> void:
	if !body.is_in_group(ignore_user):
		if body.is_in_group(target_group):
			body.take_damage(damage)
		queue_free()
