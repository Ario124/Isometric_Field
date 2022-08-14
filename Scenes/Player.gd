extends KinematicBody2D

var anim_direction = "S"
var anim_mode = "Idle"
var animation

var spell = preload("res://Scenes/Spell.tscn")
var can_fire = true
var rate_of_fire = 0.4
var shooting = false


var max_speed = 250
var speed = 0
var acceleration = 100
var move_direction = Vector2(0,0)
var moving = false
var destination = Vector2()
var movement = Vector2()

var attacking = false
var attack_direction


func _unhandled_input(event):
	if event.is_action_pressed('Click'):
		moving = true
		destination = get_global_mouse_position()
	elif event.is_action_pressed("Attack"):
		moving = false
		attacking = true
		attack_direction = rad2deg(get_angle_to(get_global_mouse_position()))
		Attack()

func _process(delta):
	AnimationLoop()
	SkillLoop()


func _physics_process(delta):
	MovementLoop()

func SkillLoop():
	if Input.is_action_pressed("Shoot") and can_fire == true:
		can_fire = false
		shooting = true
		speed = 0
		get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position())
		var spell_instance = spell.instance()
		spell_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
		spell_instance.rotation = get_angle_to(get_global_mouse_position())
		get_parent().add_child(spell_instance)
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true
		shooting = false
		speed = 200



func Attack():
	yield(get_tree().create_timer(0.4), "timeout")
	attacking = false
	anim_mode = "Idle"

func MovementLoop():
	var left = Input.is_action_pressed("a")
	var right = Input.is_action_pressed("d")
	var up = Input.is_action_pressed("w")
	var down = Input.is_action_pressed("s")
	
	move_direction.x = -int(left) + int(right)
	move_direction.y = -int(up) + int(down)
	
	var motion = move_direction.normalized() * speed
	move_and_slide(motion, Vector2(0,0))

func AnimationLoop():
	if shooting == true:
		anim_mode = "Idle"
	else:
		match move_direction:
			Vector2(-1,0):
				anim_direction = "W"
			Vector2(1,0):
				anim_direction = "E"
			Vector2(0,1):
				anim_direction = "S"
			Vector2(0,-1):
				anim_direction = "N"
			Vector2(-1,-1):
				anim_direction = "NW"
			Vector2(-1,1):
				anim_direction = "SW"
			Vector2(1,-1):
				anim_direction = "NE"
			Vector2(1,1):
				anim_direction = "SE"

		if move_direction != Vector2(0,0):
			anim_mode = "Walk"
		else:
			anim_mode = "Idle"
	
	animation = anim_mode + "_" + anim_direction
	get_node("AnimationPlayer").play(animation)

#	elif attacking:
#		if attack_direction <= 15 and attack_direction >= -15:
#			anim_direction = "E"
#		elif attack_direction <= 60 and attack_direction >= 15:
#			anim_direction = "SE"
#		elif attack_direction <= 120 and attack_direction >= 60:
#			anim_direction = "S"
#		elif attack_direction <= 165 and attack_direction >= 120:
#			anim_direction = "SW"
#		elif attack_direction >= -60 and attack_direction <= -15:
#			anim_direction = "NE"
#		elif attack_direction >= -120 and attack_direction <= -60:
#			anim_direction = "N"
#		elif attack_direction >= -165 and attack_direction <= -120:
#			anim_direction = "NW"
#		elif attack_direction <= -165 and attack_direction >= 165:
#			anim_direction = "W"
#
#		anim_mode = "Melee"

	animation = anim_mode + "_" + anim_direction
	get_node("AnimationPlayer").play(animation)


















#extends KinematicBody2D
#
#var move_direction = Vector2(0,0)
#var speed = 0
#var max_speed = 500
#var acceleration = 600
#
#
#
#func _physics_process(delta):
#	MovementLoop()
#
#func _process(delta):
#	AnimationLoop()
#
#
#func MovementLoop():
#	move_direction.x = int(Input.is_action_pressed("d")) - int(Input.is_action_pressed("a"))
#	move_direction.y = (int(Input.is_action_pressed("s")) - int(Input.is_action_pressed("w"))) / float(2)
#	var motion = move_direction.normalized() * speed
#	move_and_slide(motion)
#
#
#func AnimationLoop():
#	var anim_direction = "S"
#	var anim_mode = "Idle"
#	var animation
#	match move_direction:
#		Vector2(-1,0):
#			anim_direction = "W"
#		Vector2(1,0):
#			anim_direction = "E"
#		Vector2(0,0.5):
#			anim_direction = "S"
#		Vector2(0,-0.5):
#			anim_direction = "N"
#		Vector2(-1,-0.5):
#			anim_direction = "NW"
#		Vector2(-1,0.5):
#			anim_direction = "SW"
#		Vector2(1,-0.5):
#			anim_direction = "NE"
#		Vector2(1,0.5):
#			anim_direction = "SE"
#	if move_direction != Vector2(0,0):
#		anim_mode = "Walk"
#	else:
#		anim_mode = "Idle"
#	animation = anim_mode + "_" +  anim_direction
#	get_node("AnimationPlayer").play(animation)
