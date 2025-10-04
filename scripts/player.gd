extends CharacterBody2D

func _ready() -> void:
	velocity.x = 200

func _physics_process(delta: float) -> void:
	
	move_and_slide()
