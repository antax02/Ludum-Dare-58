extends Area2D

@onready var exit_ui: Control = $"../CanvasLayer2/ExitUi"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		LevelManager.level_num += 1
		exit_ui.visible = true
