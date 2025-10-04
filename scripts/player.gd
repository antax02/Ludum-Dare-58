extends CharacterBody2D

@export var bullet : PackedScene
var health = 100
var rotation_speed = 2
var dash_power = 5

func _ready():
	pass

func shoot():
	var b = bullet.instantiate()
	b.global_position = $ShootLeft.global_position
	b.global_rotation = $ShootLeft.global_rotation
	get_parent().add_child(b)
	b = bullet.instantiate()
	b.global_position = $ShootRight.global_position
	b.global_rotation = $ShootRight.global_rotation
	get_parent().add_child(b)

func _physics_process(delta):
	if Input.is_action_pressed("thrust"):
		velocity += (get_global_mouse_position() - global_position).normalized() * dash_power
	if Input.is_action_pressed("dash"):
		position += get_global_mouse_position().normalized() * 100
	if Input.is_action_just_pressed("shoot"):
		shoot()

	get_global_mouse_position()
	global_rotation = lerp_angle(global_rotation, (get_global_mouse_position() - global_position).angle(), rotation_speed * delta)
	move_and_slide()
