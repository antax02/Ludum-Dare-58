extends Control

const MAIN_MENU = preload("res://scenes/ui/main_menu.tscn")
const LEVEL_1 = preload("res://scenes/levels/level_1.tscn")
@onready var click_audio: AudioStreamPlayer = $ClickAudio

func _on_retry_pressed() -> void:
	click_audio.play()
	await get_tree().create_timer(0.1).timeout
	MoneyManager.money = MoneyManager.level_load_money
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	click_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
