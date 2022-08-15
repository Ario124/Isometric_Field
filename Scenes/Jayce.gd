extends KinematicBody2D

onready var hp_bar = get_node("HPBar")

var max_hp = 100
var current_hp
var percentage_hp



func _ready():
	get_node("AnimationPlayer").play("Idle_SW")
	current_hp = max_hp

func OnHit(damage):
	current_hp -= damage
	HPBarUpdate()
	if current_hp <= 0:
		OnDeath()

func HPBarUpdate():
	percentage_hp = int((float(current_hp) / max_hp) * 100)
	hp_bar.value = percentage_hp
	
	if percentage_hp >= 60:
		hp_bar.set_tint_progress("14e114")#Green
	elif percentage_hp <= 60 and percentage_hp >= 25:
		hp_bar.set_tint_progress("e1be32")#Orange
	else:
		hp_bar.set_tint_progress("e11e1e")#Red



func OnDeath():
	get_node("CollisionPolygon2D").set_deferred("disabled", true)
	get_node("AnimationPlayer").play("Death_SW")
	hp_bar.hide()
