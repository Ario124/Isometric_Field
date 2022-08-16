extends Node2D
var skill_name
var heal_amount = 20


func _ready():
	Heal()


func Heal():
	get_node("AnimationPlayer").play("Heal")
	get_parent().OnHeal(heal_amount)
	yield(get_tree().create_timer(0.6),"timeout")
	queue_free()
