extends KinematicBody2D

var max_hp = 1000
var current_hp


func _ready():
	get_node("AnimationPlayer").play("Idle_SW")
	current_hp = max_hp

func OnHit(damage):
	pass
