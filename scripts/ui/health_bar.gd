extends CanvasLayer

@onready var margin_container: MarginContainer = $MarginContainer
@onready var health_bar: ProgressBar = $MarginContainer/VBoxContainer/HealthBar

func _ready() -> void:
	health_bar.value = 100
	
func _process(delta: float) -> void:
	health_bar.value = get_tree().get_first_node_in_group("player").health
	
