extends PanelContainer

const WORLD = preload("res://scenes/world.tscn")
const MAIN_MENU = preload("res://scenes/ui/main_menu.tscn")



func _on_retry_pressed() -> void:
	get_tree().change_scene_to_packed(WORLD)

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)
