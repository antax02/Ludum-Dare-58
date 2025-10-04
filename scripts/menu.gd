extends PanelContainer

const WORLD = preload("res://scenes/world.tscn")


func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(WORLD)


func _on_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_quit_game_pressed() -> void:
	get_tree().quit()
