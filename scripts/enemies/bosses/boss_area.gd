extends Area2D

var enabled = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		enabled = true
		SignalBus.update_boss_ui.emit(enabled)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		enabled = false
		SignalBus.update_boss_ui.emit(enabled)
