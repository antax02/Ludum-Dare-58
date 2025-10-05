extends Enemy

var laser_target_entities: int = 0
var laser_charging: int = 0
var laser_cooldown: int = 3
var laser_timer: int = 0
@export var laser: PackedScene

func setup():
	max_health = 200
	health = max_health
	attack_damage = 15
	max_speed = 150
	acceleration = 600
	rotation_speed = 7
	distance = 300
	bullet_cooldown = 3

func laser_tracing(delta):
	target = get_tree().get_first_node_in_group("player")
	if laser_charging == 1:
		$LaserCanon.global_rotation = $LaserCanon.global_rotation
	else:
		$LaserCanon.global_rotation = (target.global_position - $LaserCanon.global_position).angle()

func charge_laser():
	laser_timer = 0
	laser_charging += 1
	
	if laser_timer >= laser_cooldown:
		shoot()
		laser_charging -= 1

func shoot():
	#laser_charging -= 1
	var l = laser.instantiate()
	l.global_position = $LaserCanon/ShootLaser.global_position
	l.global_rotation = $LaserCanon/ShootLaser.global_rotation
	l.target_group = "player"
	l.ignore_user = "enemies"
	l.damage = attack_damage
	add_child(l)
	#bullet_timer = (-5)

func custom_physics_process(delta):
	laser_tracing(delta)
	laser_timer += delta
	
	if laser_target_entities >= 1:
		charge_laser()

@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		laser_target_entities += 1

@warning_ignore("unused_parameter")
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		laser_target_entities -= 1
