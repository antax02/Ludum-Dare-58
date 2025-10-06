extends CharacterBody2D

@onready var left_back_1: Node2D = $Turrets/LeftBack1
@onready var left_back_2: Node2D = $Turrets/LeftBack2
@onready var left_front_1: Node2D = $Turrets/LeftFront1
@onready var left_front_2: Node2D = $Turrets/LeftFront2
@onready var right_back_1: Node2D = $Turrets/RightBack1
@onready var right_back_2: Node2D = $Turrets/RightBack2
@onready var right_front_1: Node2D = $Turrets/RightFront1
@onready var right_front_2: Node2D = $Turrets/RightFront2

@onready var gunship_torpedo_launcher: Node2D = $GunshipTorpedoLauncher
@onready var gunship_torpedo_launcher_2: Node2D = $GunshipTorpedoLauncher2

var player: Node2D
var left_front_battery: Array[Node2D] = []
var left_back_battery: Array[Node2D] = []
var right_front_battery: Array[Node2D] = []
var right_back_battery: Array[Node2D] = []

var max_health = 5000
var health = max_health


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	left_front_battery = [left_front_1, left_front_2]
	left_back_battery = [left_back_1, left_back_2]
	right_front_battery = [right_front_1, right_front_2]
	right_back_battery = [right_back_1, right_back_2]

func _physics_process(delta: float) -> void:
	player = get_tree().get_first_node_in_group("player")
	set_battery_enable(left_front_battery, false)
	set_battery_enable(left_back_battery, false)
	set_battery_enable(right_front_battery, false)
	set_battery_enable(right_back_battery, false)
	gunship_torpedo_launcher.enabled = false
	gunship_torpedo_launcher_2.enabled = false
	if player:
		var angle_to_player = (player.global_position - global_position).angle()
		if angle_to_player >= 0:
			if angle_to_player >= PI/2:
				set_battery_enable(right_back_battery, true)
			else:
				set_battery_enable(right_front_battery, true)
			gunship_torpedo_launcher_2.enabled = true
		else:
			if angle_to_player < -PI/2:
				set_battery_enable(left_back_battery, true)
			else:
				set_battery_enable(left_front_battery, true)
			gunship_torpedo_launcher.enabled = true
		
func set_battery_enable(battery: Array[Node2D], state: bool) -> void:
	for turret in battery:
		if turret:
			turret.enabled = state

func take_damage(dmg):
	health -= dmg
	if health <= 0:
		SignalBus.spawn_boss_drop.emit()
		queue_free()
