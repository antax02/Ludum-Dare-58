extends CharacterBody2D

@export var bullet: PackedScene
var health: int = 100
var rotation_speed: int = 2
var speed: int = 200
var dash_target_entities: int = 0
var dash_cooldown: float = 0

func _ready():
	pass

func shoot():
	var b = bullet.instantiate()
	b.global_position = $ShootLeft.global_position
	b.global_rotation = $ShootLeft.global_rotation
	b.target_group = "enemies"
	b.ignore_user = "player"
	b.damage = 20
	get_parent().add_child(b)
	b = bullet.instantiate()
	b.global_position = $ShootRight.global_position
	b.global_rotation = $ShootRight.global_rotation
	b.target_group = "enemies"
	b.ignore_user = "player"
	b.damage = 20
	get_parent().add_child(b)
	
func take_damage(damage):
	health -= damage
	if health <= 0:
		# money += 10
		#get_tree().get_root().get_node("/root/DeathScreen").show_death_screen()
		queue_free()

func _physics_process(delta):
	var dash_target = $Area2D
	dash_cooldown += delta
	
	if Input.is_action_pressed("thrust"):
		velocity += (get_global_mouse_position() - global_position).normalized() * speed * delta
	if Input.is_action_pressed("dash") and dash_target_entities == 0 and dash_cooldown >= 1.5:
		position = dash_target.global_position
		dash_cooldown = 0
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	global_rotation = lerp_angle(global_rotation, (get_global_mouse_position() - global_position).angle(), rotation_speed * delta)
	move_and_slide()

@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body: Node2D) -> void:
	dash_target_entities += 1

@warning_ignore("unused_parameter")
func _on_area_2d_body_exited(body: Node2D) -> void:
	dash_target_entities -= 1
