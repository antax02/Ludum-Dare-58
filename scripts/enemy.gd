class_name Enemy extends CharacterBody2D

var target: Node2D
var max_health: int = 100
var health: int = max_health
var attack_damage: int = 10
var max_speed: int = 200
var acceleration: int = 800
var rotation_speed: int = 7
var distance: int = 400
var bullet_cooldown: float = 0
@export var bullet: PackedScene


func setup():
	pass

func _ready():
	setup()

func shoot():
	var b = bullet.instantiate()
	b.global_position = $ShootCenter.global_position
	b.global_rotation = $ShootCenter.global_rotation
	b.target_group = "player"
	b.ignore_user = "enemies"
	b.damage = 5
	get_parent().add_child(b)

func follow_target(delta):
	target = get_tree().get_first_node_in_group("player")
	rotation = lerp_angle(rotation, (target.global_position - global_position).angle(), -(cos(PI * rotation_speed * delta) - 1) / 2)
	
	if position.distance_to(target.position) > distance:
		if position.distance_to(target.position) > (distance + 100):
			velocity += (target.global_position - global_position).normalized() * acceleration * delta
	else:
		#velocity = velocity.normalized() * (velocity.length() * (0.1 * delta))
		velocity = velocity.normalized() * max(velocity.length() - 200 * delta, 0)

func take_damage(damage):
	health -= damage
	if health <= 0:
		# money += 10
		queue_free()

func _physics_process(delta):
	bullet_cooldown += delta
	follow_target(delta)
	
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	
	if position.distance_to(target.position) < distance + 100 and bullet_cooldown >= 0.5:
		shoot()
		bullet_cooldown = 0
	
	move_and_slide()
