extends Enemy

var laser_charging: int = 0

@export var laser: PackedScene

func setup():
	max_health = 200
	health = max_health
	attack_damage = 15
	max_speed = 150
	acceleration = 600
	rotation_speed = 7
	distance = 500
	bullet_cooldown = 3

func laser_tracing(delta):
	target = get_tree().get_first_node_in_group("player")
	if laser_charging == 1:
		$LaserCanon.global_rotation = $LaserCanon.global_rotation
	else:
		$LaserCanon.global_rotation = (target.global_position - $LaserCanon.global_position).angle()

func shoot():
	laser_charging += 1
	bullet_timer = (-6)
	print("shoot")

func shoot_laser():
	var l = laser.instantiate()
	l.global_position = $LaserCanon/ShootLaser.global_position
	l.global_rotation = $LaserCanon/ShootLaser.global_rotation
	l.target_group = "player"
	l.ignore_user = "enemies"
	l.damage = attack_damage
	get_parent().add_child(l)

func custom_physics_process(delta):
	laser_tracing(delta)
	
	if bullet_timer >= (-4) and bullet_timer <= (-1):
		shoot_laser()
		bullet_timer = 0
		laser_charging -= 1
		print("fire laser")
