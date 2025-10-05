extends CanvasLayer

@onready var label = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/coin_count
signal counter_update 

func _ready() -> void:
	money_count()
	
func _on_counter_update() -> void:
	money_count()

func money_count():
	label.text = str(MoneyManager.money)
