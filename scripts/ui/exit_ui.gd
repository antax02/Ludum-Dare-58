extends Control

const LEVEL_2 = preload("res://scenes/levels/level_2.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")
