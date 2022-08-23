extends KinematicBody2D

onready var hp_bar = get_node("HPBar")

var max_hp = 500
var current_hp
var percentage_hp = 100
var can_heal = true
var dead = false


func _ready():
	get_node("AnimationPlayer").play("Idle_SW")
	current_hp = max_hp

func _process(delta):
	if percentage_hp <= 90 and can_heal == true:
		can_heal = false
		yield(get_tree().create_timer(0.35), "timeout")
		if dead == true:
			pass
		else:
			var skill = load("res://Assets/Skills/SingleTargetHeal.tscn")
			var skill_instance = skill.instance()
			add_child(skill_instance)
			yield(get_tree().create_timer(1), "timeout")
			can_heal = true



func OnHit(damage):
	current_hp -= damage
	HPBarUpdate()
	if current_hp <= 0:
		OnDeath()


func OnHeal(heal_amount):
	current_hp += heal_amount
	if current_hp >= max_hp:
		current_hp = max_hp
	HPBarUpdate()

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
	dead = true
	get_node("CollisionPolygon2D").set_deferred("disabled", true)
	get_node("AnimationPlayer").play("Death_SW")
	hp_bar.hide()
	yield(get_tree().create_timer(3), "timeout")
	z_index = -1
