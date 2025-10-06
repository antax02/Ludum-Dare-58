extends PanelContainer
@onready var click_audio: AudioStreamPlayer = $"../ClickAudio"

func _on_back_pressed() -> void:
	click_audio.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
