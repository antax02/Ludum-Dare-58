extends Area2D

var speed: int = 1000
var damage: int = 10
var target_group
var ignore_user

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
