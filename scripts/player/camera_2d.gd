extends Camera2D

@export var target: Node2D

func _physics_process(delta):
	if target:
		global_position = global_position.lerp(target.global_position, ease(25.0 * delta, -2.0))
