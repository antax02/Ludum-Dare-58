class_name Enemy extends CharacterBody2D

var target: Node2D
var health: int = 100
var damage: int = 10
var speed: int = 100
var rotation_speed: int = 5
var distance: int = 200


func setup():
	pass

func _ready():
	setup()

func _physics_process(delta):
	follow_target(delta)

func follow_target(delta):
	target = get_tree().get_first_node_in_group("player")
	rotation = lerp_angle(rotation, (target.global_position - global_position).angle(), -(cos(PI * rotation_speed * delta) - 1) / 2)
	
	if position.distance_to(target.position) > distance:
		position = position.move_toward(target.position, speed * delta)
