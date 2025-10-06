extends Area2D

@export var enabled = false

func _ready() -> void:
	SignalBus.spawn_boss_drop.connect(_spawn_boss_drop)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && enabled:
		MoneyManager.level_load_money = MoneyManager.money
		var current_scene_file = get_tree().current_scene.scene_file_path
		var file_name = current_scene_file.get_file().get_basename()  # e.g. "level_1"

		# Parse level number correctly
		var level_number = file_name.substr("level_".length()).to_float()
		Global.current_level = level_number

		var next_level_number = level_number + 0.5

		var next_scene_path: String
		if int(next_level_number) != next_level_number:
			next_scene_path = "res://scenes/levels/shop.tscn"
		else:
			next_scene_path = "res://scenes/levels/level_" + str(int(next_level_number)) + ".tscn"
			
		get_tree().get_first_node_in_group("level_transition").visible = true
		get_tree().get_first_node_in_group("player").health = 100
		await get_tree().create_timer(10).timeout

		call_deferred("_change_scene", next_scene_path)


func _change_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)

func _spawn_boss_drop():
	visible = true
	enabled = true
