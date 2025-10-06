extends CharacterBody2D

@export var bullet: PackedScene
var health: int = 100
var rotation_speed: int = 10
var speed: int = 200
var dash_target_entities: int = 0
var dash_cooldown: float = 2
var dead = false
var rotation_freeze_time: float = 10.0

func _ready():
	pass

func shoot():
	var b = bullet.instantiate()
	if b:
		b.global_position = $ShootLeft.global_position
		b.global_rotation = $ShootLeft.global_rotation
		b.target_group = "enemies"
		b.ignore_user = "player"
		b.damage = 20
		get_parent().add_child(b)
	b = bullet.instantiate()
	if b:
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
		get_tree().get_first_node_in_group("death").visible = true
		dead = true

func _physics_process(delta):

	var dash_target = $Area2D
	dash_cooldown += delta
	rotation_freeze_time += delta
	
	if !dead:
		if Input.is_action_pressed("thrust"):
			velocity += (get_global_mouse_position() - global_position).normalized() * speed * delta
			$Body/LeftEngine/LeftExhaust.visible = true
			$Body/RightEngine/RightExhaust.visible = true
		else:
			$Body/LeftEngine/LeftExhaust.visible = false
			$Body/RightEngine/RightExhaust.visible = false

		
		if Input.is_action_pressed("dash") and dash_target_entities == 0 and dash_cooldown >= 1.5:
			$DashEffect.visible = true
			$DashEffectAnimation.play("hide")

			global_rotation = (get_global_mouse_position() - global_position).normalized().angle()
			
			position = dash_target.global_position
			
			velocity = (dash_target.global_position - global_position).normalized() * velocity.length()
			
			rotation_freeze_time = 0.1
			dash_cooldown = 0
		
		if Input.is_action_just_pressed("shoot"):
			shoot()
		
		if rotation_freeze_time >= 0.2:
			global_rotation = lerp_angle(global_rotation, (get_global_mouse_position() - global_position).angle(), ease(rotation_speed * delta, -2.2))
	move_and_slide()

func hide_dash_effect():
	$DashEffect.visible = false

@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body: Node2D) -> void:
	dash_target_entities += 1

@warning_ignore("unused_parameter")
func _on_area_2d_body_exited(body: Node2D) -> void:
	dash_target_entities -= 1
