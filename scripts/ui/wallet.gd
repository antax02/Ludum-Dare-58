extends CanvasLayer

@onready var label = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/coin_count


func _ready() -> void:
	money_count()
	SignalBus.counter_update.connect(_on_counter_update)
	
func _on_counter_update() -> void:
	money_count()

func money_count():
	label.text = "Score: " + str(MoneyManager.money)
