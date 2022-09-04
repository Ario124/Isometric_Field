extends RigidBody2D

onready var animation_tree = get_node("AnimationTree")

var projectile_speed = 600
var life_time= 3
var direction
var impulse_rotation
var damage

func _ready():
	Server.FetchSkillDamage("Ice_Spear", get_instance_id())
	animation_tree.set( 'parameters/blend_position' , direction)
	apply_impulse(Vector2(), Vector2(projectile_speed, 0). rotated(impulse_rotation))
	SelfDestruct()

func SetDamage(s_damage):
	damage = s_damage



func SelfDestruct():
	yield(get_tree().create_timer(life_time), "timeout")
	queue_free()
	
func _on_IceSpear_body_entered(body):
	get_node("CollisionPolygon2D").set_deferred("disabled", true)
	if body.is_in_group("Enemies"):
		body.OnHit(damage)
	self.hide()
