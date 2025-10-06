extends Path2D

@onready var head: PathFollow2D = $Head
@export var projectile: PackedScene

var phase: int = 1
var health: int = 5000
var max_health: int = 5000

var dash_timer: float = 0.0
var dash_cooldown: float = 4.0
var dash_length: float = 2.5
var dash_speed: float = 700.0
var normal_speed: float = 100.0

var range: float = 1000

var shoot_timer: float = 0.0
var shoot_interval: float = 1.5


func _process(delta: float) -> void:
	if phase == 1 and health <= max_health * 0.5:
		phase = 2
		shoot_interval = 1.0
		dash_cooldown = 2.0
		await get_tree().create_timer(1.0).timeout
		while phase == 2:
			
			for i in range(36):
				var angle := deg_to_rad(i * 10)
				if global_position.distance_to(get_tree().get_first_node_in_group("player").global_position) < range:
					spit(angle, 8.0, 300.0)
			await get_tree().create_timer(3.5).timeout


	dash_timer += delta
	if head.speed == dash_speed and dash_timer >= dash_length:
		head.speed = normal_speed

	if dash_timer >= dash_cooldown:
		dash_timer = 0.0
		dash()

	shoot_timer += delta
	if shoot_timer >= shoot_interval:
		shoot_timer = 0.0
		if phase == 1:
			spit_at_player()


func dash() -> void:
	head.speed = dash_speed
	dash_timer = 0.0
	

func spit_at_player() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if global_position.distance_to(get_tree().get_first_node_in_group("player").global_position) < range:
		spit((player.global_position - head.global_position).angle(), 10.0, 400.0)


func spit(angle: float, damage: float, speed: float) -> void:
	var s = projectile.instantiate()
	s.rotation = angle
	s.global_position = head.global_position
	s.target_group = "player"
	s.ignore_user = "boss"
	s.damage = damage
	s.speed = speed
	get_parent().add_child(s)


func take_damage(damage):
	health -= damage
	if health <= 0:
		SignalBus.spawn_boss_drop.emit()
		queue_free()
