extends Node2D

var target: Node2D
var enabled: bool = true
var can_shoot: bool = false
var shoot_timer: float = 0
var fire_rate: float = 6
@export var max_range: float = 100

const GUNSHIP_TORPEDO = preload("uid://bda5q5ftg84nm")


var rotation_speed: float = 30
var defalut_rotation

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")
	defalut_rotation = rotation

func _physics_process(delta: float) -> void:
	shoot_timer += delta
	can_shoot = fire_rate < shoot_timer
	
	if !target:
		target = get_tree().get_first_node_in_group("player")
	if target && enabled:
		rotation = lerp_angle(rotation, (target.global_position - global_position).angle() + (PI/2), ease(rotation_speed * delta, 2.6) / 2)
		if angle_difference(rotation, (target.global_position - global_position).angle() + (PI/2) < 5):
			if can_shoot:
				shoot()
	if !enabled:
		rotation = lerp_angle(rotation, defalut_rotation, ease(rotation_speed * delta, 2.6) / 2)

func shoot() -> void:
	var b = GUNSHIP_TORPEDO.instantiate()
	b.global_position = $Muzzle.global_position
	b.global_rotation = $Muzzle.global_rotation - (PI/2)
	get_tree().get_first_node_in_group("player").add_sibling(b)
		
	shoot_timer	= 0
