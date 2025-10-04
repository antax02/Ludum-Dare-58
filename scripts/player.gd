extends CharacterBody2D

@export var Bullet : PackedScene
var health = 100
var rotation_speed = 2
var dash_power = 5

func _ready():
	pass

func shoot():
	var b = Bullet.instantiate()
	b.global_position = $Shoot.global_position
	b.global_rotation = $Shoot.global_rotation
	get_parent().add_child(b)
	b.transform = $Shoot.transform

func _physics_process(delta):
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("dash"):
		velocity += (get_global_mouse_position() - global_position).normalized() * dash_power
	if Input.is_action_pressed("break"):
		velocity = velocity.normalized() * max(velocity.length() - 150 * delta, 0)
	if Input.is_action_just_pressed("shoot"):
		shoot()

	get_global_mouse_position()
	global_rotation = lerp_angle(global_rotation, (get_global_mouse_position() - global_position).angle(), rotation_speed * delta)

	move_and_slide()
	#if velocity.length() > 0: 
		#velocity = velocity.normalized() * speed
