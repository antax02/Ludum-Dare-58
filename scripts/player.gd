extends CharacterBody2D

func _ready() -> void:
	velocity.x = 30

func _physics_process(delta: float) -> void:
	
	move_and_slide()
