extends Node2D

@onready var out_of_bounds_effect: CanvasLayer = $OutOfBoundsEffect
@onready var effect_rect: ColorRect = $OutOfBoundsEffect/EffectRect

@onready var stars_parallax: Parallax2D = $Background/Stars
@onready var far_objects_parallax: Parallax2D = $Background/FarObjects
@onready var near_objects_parallax: Parallax2D = $Background/NearObjects
@onready var far_rare_objects_parallax: Parallax2D = $Background/FarRareObjects
@onready var near_rare_objects_parallax: Parallax2D = $Background/NearRareObjects

@export var stars: Array[PackedScene] = []
@export var far_objects: Array[PackedScene] = []
@export var near_objects: Array[PackedScene] = []
@export var far_rare_objects: Array[PackedScene] = []
@export var near_rare_objects: Array[PackedScene] = []

@export var star_count: int = 500
@export var far_objects_count: int = 150
@export var near_objects_count: int = 50
@export var far_rare_objects_count: int = 5
@export var near_rare_objects_count: int = 5

var inside_bounds: bool = true
var bounds_exit_position: Vector2
var outside_bounds_timer: float = 0.0
var spawn_area: Vector2 = Vector2(10000, 10000)

func _ready() -> void:
	spawn_objects(stars, star_count, stars_parallax, false, true)
	spawn_objects(far_objects, far_objects_count, far_objects_parallax, true, true)
	spawn_objects(near_objects, near_objects_count, near_objects_parallax, true, true)
	spawn_objects(far_rare_objects, far_rare_objects_count, far_rare_objects_parallax, true, false)
	spawn_objects(near_rare_objects, near_rare_objects_count, near_rare_objects_parallax, true, false )
	
func _process(delta: float) -> void: 
	if not inside_bounds:
		outside_bounds_timer += delta
	
	effect_rect.material.set_shader_parameter("scanline_strength", clamp(outside_bounds_timer / 10, 0, 0.4))
	effect_rect.material.set_shader_parameter("shake_rate", clamp(outside_bounds_timer / 10, 0, 0.35))
	
func spawn_objects(objects: Array[PackedScene], object_count: int, parallax_layer: Parallax2D, random_rotation: bool, random_scale: bool) -> void:
	for i in range(object_count):
		var instance = objects[randi_range(0, len(objects) - 1)].instantiate()
		instance.position = Vector2(randf_range(-spawn_area.x / 2, spawn_area.x / 2), randf_range(-spawn_area.y / 2, spawn_area.y / 2))
		if random_scale:
			instance.scale = Vector2.ONE * randf_range(0.4, 1.6)
		if random_rotation:
			instance.rotation = randf_range(0, 2 * PI)
		parallax_layer.add_child(instance)
	
func _on_playable_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		inside_bounds = true
		out_of_bounds_effect.visible = !inside_bounds
		outside_bounds_timer = 0.0

func _on_playable_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		inside_bounds = false
		out_of_bounds_effect.visible = !inside_bounds
		bounds_exit_position = body.global_position
