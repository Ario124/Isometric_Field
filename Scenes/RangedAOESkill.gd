extends Area2D


var damage
var damage_delay_time
var remove_delay_time
var skill_name

func _ready():
	damage = DataImport.skill_data[skill_name].SkillDamage
	damage_delay_time = DataImport.skill_data[skill_name].DamageDelayTime
	remove_delay_time = DataImport.skill_data[skill_name].RemoveDelayTime
	
	var skill_texture = load("res://Assets/Projectiles/" + skill_name + ".png")
	get_node("Sprite").set_texture(skill_texture)
	AOEAttack()
	SelfDestruct()


func AOEAttack():
	get_node("AnimationPlayer").play(skill_name)
	yield(get_tree().create_timer(float(damage_delay_time)), "timeout")
	var targets = get_overlapping_bodies()
	for target in targets:
		target.OnHit(damage)
		SelfDestruct()

func SelfDestruct():
	yield(get_tree().create_timer(remove_delay_time), "timeout")
	queue_free()
