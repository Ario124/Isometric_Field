extends RigidBody2D

var projectile_speed
var life_time = 3
var fire_direction
var animation
var damage
var skill_name


func _ready():
	Server.FetchSkillDamage("Ice_Spear", get_instance_id())

	projectile_speed = DataImport.skill_data[skill_name].ProjectileSpeed
	var skill_texture = load("res://Assets/Projectiles/" + skill_name + ".png")
	get_node("Projectile").set_texture(skill_texture)
	
	
	
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
	SelfDestruct()
	SetAnimation()

func SetDamage(s_damage):
	damage = s_damage



func SetAnimation():
	if fire_direction <= 15 and fire_direction >= -15:
		animation = "Fire_E"
	elif fire_direction <= 60 and fire_direction >= 15:
		animation = "Fire_SE"
		get_node("Projectile").rotation_degrees -= 30
	elif fire_direction <= 120 and fire_direction >= 60:
		animation = "Fire_S"
		get_node("Projectile").rotation_degrees -= 90
	elif fire_direction <= 165 and fire_direction >= 120:
		animation = "Fire_SW"
		get_node("Projectile").rotation_degrees -= 150
	elif fire_direction >= -60 and fire_direction <= -15:
		animation = "Fire_NE"
		get_node("Projectile").rotation_degrees += 30
	elif fire_direction >= -120 and fire_direction <= -60:
		animation = "Fire_N"
		get_node("Projectile").rotation_degrees += 90
	elif fire_direction >= -165 and fire_direction <= -120:
		animation = "Fire_NW"
		get_node("Projectile").rotation_degrees += 150
	elif fire_direction <= -165 or fire_direction >= 165:
		animation = "Fire_W"
		get_node("Projectile").rotation_degrees -= 180
	
	get_node("AnimationPlayer").play(animation)

func SelfDestruct():
	yield(get_tree().create_timer(life_time), "timeout")
	queue_free()


func _on_Spell_body_entered(body):
	get_node("CollisionPolygon2D").set_deferred("disabled", true)
	if body.is_in_group("Enemies"):
		body.OnHit(damage)
	self.hide()
