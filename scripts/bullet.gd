extends Area2D

var speed: int = 1000
var damage: int = 20

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(damage)
	queue_free()
