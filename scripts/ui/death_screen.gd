extends Control

const MAIN_MENU = preload("res://scenes/ui/main_menu.tscn")
const LEVEL_1 = preload("res://scenes/levels/level_1.tscn")

func _on_retry_pressed() -> void:
	MoneyManager.money = MoneyManager.level_load_money
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
