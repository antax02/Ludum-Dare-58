extends CanvasLayer

@export var boss_name: String = "boss"
@onready var label: Label = $MarginContainer/VBoxContainer/Label
@onready var margin_container: MarginContainer = $MarginContainer
@onready var progress_bar: ProgressBar = $MarginContainer/VBoxContainer/ProgressBar
var boss

func _ready() -> void:
	SignalBus.update_boss_ui.connect(_update_boss_ui)
	label.text = boss_name
	
func _process(delta: float) -> void:
	boss = get_tree().get_first_node_in_group("boss")
	if boss:
		progress_bar.value = float(boss.health) / float(boss.max_health) * 100.0
	else:
		progress_bar.value = 0
		margin_container.visible = false

func _update_boss_ui(state):
	margin_container.visible = state
