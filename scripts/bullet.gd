extends Area2D

var speed: int = 1000
var damage: int
var target_group
var ignore_user

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if !body.is_in_group(ignore_user):
		if body.is_in_group(target_group):
			body.take_damage(damage)
		queue_free()
