extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Increment current level because the player finished the previous one
		Global.current_level += 1

		var next_level_path = "res://scenes/levels/level_" + str(int(Global.current_level)) + ".tscn"

		# Use deferred call to avoid physics callback error
		call_deferred("_change_scene", next_level_path)


func _change_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)
