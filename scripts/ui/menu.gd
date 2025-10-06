extends PanelContainer

@onready var play_button = $marign/layout/buttons/start
@onready var credits_button = $marign/layout/buttons/credits
@onready var quit_button = $marign/layout/buttons/quit
@onready var title_label = $marign/layout/buttons/Game_Name
@onready var click_audio: AudioStreamPlayer = $marign/ClickAudio

var button_original_positions = {}

func _ready():
	#play_button.pressed.connect(_on_start_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	var buttons = get_all_buttons()
	ButtonStyler.apply_style_to_buttons(buttons, HORIZONTAL_ALIGNMENT_LEFT)
	
	await get_tree().process_frame
	_setup_hover_animations(buttons)


func get_all_buttons() -> Array[Button]:
	return [play_button, credits_button, quit_button]


func _setup_hover_animations(buttons: Array[Button]) -> void:
	for button in buttons:
		button_original_positions[button] = button.position.x
		button.mouse_entered.connect(_on_button_hover.bind(button))
		button.mouse_exited.connect(_on_button_unhover.bind(button))

func _on_button_hover(button: Button):
	if button_original_positions.has(button):
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(button, "position:x", 
			button_original_positions[button] + ButtonStyler.HOVER_OFFSET, 
			ButtonStyler.HOVER_DURATION)

func _on_button_unhover(button: Button):
	if button_original_positions.has(button):
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(button, "position:x", 
			button_original_positions[button], 
			ButtonStyler.HOVER_DURATION)

func _on_start_pressed() -> void:
	click_audio.play()
	await get_tree().create_timer(0.07).timeout
	# Ensure we go to the latest level
	var latest_level_number = int(Global.current_level)
	var next_scene_path = "res://scenes/levels/level_" + str(latest_level_number) + ".tscn"

	# Deferred call is safer in case the button is pressed during physics
	call_deferred("_change_scene", next_scene_path)


func _change_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/credits.tscn")



func _on_quit_pressed() -> void:
	get_tree().quit()
