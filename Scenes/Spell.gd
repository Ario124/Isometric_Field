extends RigidBody2D

var projectile_speed = 700
var life_time = 1

func _ready():
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))

func SelfDestruct():
	yield(get_tree().create_timer(life_time), "timeout")
	queue_free()


func _on_Spell_body_entered(body):
	self.hide()
