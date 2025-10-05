extends CharacterBody2D

var target
var rotation_speed = 40
var move_speed = 150
var tracking = true
var tracked = false
var attack_damage = 40
var lifetime = 10.0
var health = 30
var target_group
var ignore_user

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")
	get_tree().create_timer(lifetime).timeout.connect(queue_free)

func _physics_process(delta: float) -> void:
	if !is_instance_valid(target):
		tracking = false
	
	if tracking and target:
		
		rotation = lerp_angle(rotation, (target.global_position - global_position).angle(), ease(rotation_speed * delta, 2.6) / 2)
		
		if tracked and abs(angle_difference(rotation, (target.global_position - global_position).angle())) > deg_to_rad(60):
			tracking = false
		elif abs(angle_difference(rotation, (target.global_position - global_position).angle())) < deg_to_rad(30):
			tracked = true
	
	velocity = Vector2.RIGHT.rotated(rotation) * move_speed
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): 
		if body.has_method("take_damage"):
			body.take_damage(attack_damage)
		queue_free()

func take_damage(damage):
	health -= damage
	if health <= 0:
		queue_free()
