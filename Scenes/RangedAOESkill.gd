extends Area2D


var damage = 30
var animation = "Lava_Bomb"
var damage_delay_time = 0.3
var remove_delay_time = 3
var skill_name

func _ready():
	AOEAttack()
	SelfDestruct()


func AOEAttack():
	get_node("AnimationPlayer").play(animation)
	yield(get_tree().create_timer(damage_delay_time), "timeout")
	var targets = get_overlapping_bodies()
	for target in targets:
		target.OnHit(damage)
		SelfDestruct()

func SelfDestruct():
	yield(get_tree().create_timer(remove_delay_time), "timeout")
	queue_free()
