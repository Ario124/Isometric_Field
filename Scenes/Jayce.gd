extends KinematicBody2D

var max_hp = 100
var current_hp


func _ready():
	get_node("AnimationPlayer").play("Idle_SW")
	current_hp = max_hp

func OnHit(damage):
	current_hp -= damage
	if current_hp <= 0:
		OnDeath()


func OnDeath():
	get_node("CollisionPolygon2D").set_deferred("disabled", true)
	get_node("AnimationPlayer").play("Death_SW")
