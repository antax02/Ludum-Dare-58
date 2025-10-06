extends CanvasLayer

@export var target: Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	if target:
		sprite_2d.rotation = (target.global_position - get_tree().get_first_node_in_group("player").global_position).angle() + PI/2
