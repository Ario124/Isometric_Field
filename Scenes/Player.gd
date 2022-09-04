#extends KinematicBody2D
#
#var icespear = preload("res://Scenes/RangedSingleTargetSkill.tscn")
#
#onready var animation_tree = get_node("AnimationTree")
#onready var animation_mode = animation_tree.get("parameters/playback")
#var max_speed = 300
#var speed = 0
#var acceleration = 900
#var destination = Vector2()
#var movement = Vector2()
#var moving = false
#var attacking = false
#
#func _ready():
#	pass
#
#
#func _unhandled_input(event):
#	if event.is_action_pressed('Click'):
#		moving = true
#		destination = get_global_mouse_position()
#	elif event.is_action_pressed('Attack'):
#		moving = false
#		attacking = true
#		animation_tree.set('parameters/Melee/blend_position', position.direction_to(get_global_mouse_position()).normalized())
#		animation_tree.set('parameters/Idle/blend_position', position.direction_to(get_global_mouse_position()).normalized())
#		Attack()
#
#func process(delta):
#	pass
#
#
#
#func physics_process(delta):
#	MovementLoop(delta)
#
#func MovementLoop(delta):
#	if moving == false or attacking == true:
#		speed = 0
#	else:
#		speed += acceleration * delta
#		if speed > max_speed:
#			speed = max_speed
#		movement = position.direction_to(destination) * speed
#		if position.distance_to(destination) > 10:
#			movement = move_and_slide(movement)
#			animation_tree.set('parameters/Walk/blend_position', movement.normalized())
#			animation_tree.set('parameters/Idle/blend_position', movement.normalized())
#			animation_mode.travel("Walk")
#		else:
#			moving = false
#			animation_mode.travel("Idle")
#
#
#func Attack():
#	#var fire_direction = (get_angle_to(get_global_mouse_position())/3.14)*180
#	get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position()- Vector2(0,-20))
#	var icespear_instance = icespear.instance()
#	icespear_instance.impulse_rotation = get_angle_to(get_global_mouse_position()- Vector2(0,-20))
#	icespear_instance.position = get_node("TurnAxis/Position2D").get_global_position()
#	icespear_instance.direction = get_node("TurnAxis/Position2D").get_global_position().direction_to(get_global_mouse_position()).normalized()
#	get_parent().add_child(icespear_instance)
#
#	animation_mode.travel("Melee")
#	yield(get_tree().create_timer(0.4), "timeout")
#	attacking = false







extends KinematicBody2D

var icespear = preload("res://Scenes/IceSpear.tscn")

onready var animation_tree = get_node("AnimationTree")
onready var animation_mode = animation_tree.get("parameters/playback")

var max_speed = 350
var speed = 0
var acceleration = 600
var destination = Vector2()
var movement = Vector2()
var moving = false
var attacking = false


func _ready():
	pass

func _unhandled_input(event):
	if event.is_action_pressed('Click'):
		moving = true
		destination = get_global_mouse_position()
	elif event.is_action_pressed("Attack"):
		moving = false
		attacking = true
		print(position.direction_to(get_global_mouse_position()).normalized())
		animation_tree.set('parameters/Cast/blend_position', position.direction_to(get_global_mouse_position()).normalized())
		animation_tree.set('parameters/Idle/blend_position', position.direction_to(get_global_mouse_position()).normalized())
		Attack()

func _process(delta):
	pass


func _physics_process(delta):
	MovementLoop(delta)


func MovementLoop(delta):
	if moving == false or attacking == true:
		speed = 0
	else:
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
		movement = position.direction_to(destination) * speed

		if position.distance_to(destination) > 10:
			movement = move_and_slide(movement)
			animation_tree.set('parameters/Walk/blend_position', position.direction_to(get_global_mouse_position()).normalized())
			animation_tree.set('parameters/Idle/blend_position', position.direction_to(get_global_mouse_position()).normalized())
			animation_mode.travel("Walk")
		else:
			moving = false
			animation_mode.travel("Idle")

func Attack():
	get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position()- Vector2(0,-20))
	var icespear_instance = icespear.instance()
	icespear_instance.impulse_rotation = get_angle_to(get_global_mouse_position()- Vector2(0,-20))
	icespear_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
	icespear_instance.direction = get_node("TurnAxis/CastPoint").get_global_position().direction_to(get_global_mouse_position().normalized())
	get_parent().add_child(icespear_instance)
	
	animation_mode.travel("Cast")
	yield(get_tree().create_timer(0,4), "timeout")
	attacking = false

## Add animation here
func AnimationLoop():
	pass


func OnHeal(heal_amount):
	pass


