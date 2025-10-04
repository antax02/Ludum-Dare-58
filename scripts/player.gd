extends CharacterBody2D

var health = 100
var dmg = 10
var bullet_speed
var rotation_speed = 2
var dash_power = 5

func _ready():
	pass

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
		velocity = velocity.normalized() * max(velocity.length() - 50 * delta, 0)

	get_global_mouse_position()
	global_rotation = lerp_angle(global_rotation, (get_global_mouse_position() - global_position).angle(), rotation_speed * delta)

	move_and_slide()
	#if velocity.length() > 0: 
		#velocity = velocity.normalized() * speed
