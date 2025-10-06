extends CanvasLayer

@export var boss_name: String = "boss"
@onready var label: Label = $MarginContainer/VBoxContainer/Label
@onready var margin_container: MarginContainer = $MarginContainer
@onready var progress_bar: ProgressBar = $MarginContainer/VBoxContainer/ProgressBar
var boss
var is_in_boss_area: bool = false  # Add this flag

func _ready() -> void:
	SignalBus.update_boss_ui.connect(_update_boss_ui)
	label.text = boss_name
	margin_container.visible = false  # Start hidden
	
func _process(delta: float) -> void:
	boss = get_tree().get_first_node_in_group("boss")
	if boss and is_in_boss_area:  # Only update if we should be showing
		progress_bar.value = float(boss.health) / float(boss.max_health) * 100.0

func _update_boss_ui(state):
	is_in_boss_area = state
	margin_container.visible = state
