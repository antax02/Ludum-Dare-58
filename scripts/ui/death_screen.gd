extends Control

const MAIN_MENU = preload("res://scenes/ui/main_menu.tscn")
const LEVEL_1 = preload("uid://bs4u3p8mk0b4h")

func _on_retry_pressed() -> void:
	#get_tree().change_scene_to_file("uid://bs4u3p8mk0b4h")
	MoneyManager.money = MoneyManager.level_load_money
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
