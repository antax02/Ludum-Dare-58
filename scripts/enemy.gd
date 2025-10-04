extends CharacterBody2D

var target: Node2D
var health: int = 100
var damage: int = 10
var speed: int = 4

func player_target():
	target = get_tree().get_first_node_in_group("player")
