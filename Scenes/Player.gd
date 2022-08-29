extends KinematicBody2D


onready var animation_tree = get_node("AnimationTree")
onready var animation_mode = animation_tree.get("parameters/playback")



var lava_bomb = preload("res://Scenes/RangedAOESkill.tscn")
var can_fire = true
var rate_of_fire = 0.4
var rate_of_fire2 = 0.9
var shooting = false
var shooting2 = false

var fire_direction
var max_speed = 350
var speed = 250
var acceleration = 100
var moving = false
var destination = Vector2()
var movement = Vector2()

var attacking = false
var selected_skill
var skill_type




func _unhandled_input(event):
	if event.is_action_pressed('Click'):
		moving = true
		destination = get_global_mouse_position()
	elif event.is_action_pressed("Attack"):
		moving = false
		attacking = true
		print(position.direction_to(get_global_mouse_position()).normalized())
		animation_tree.set('parameters/Melee/blend_position', position.direction_to(get_global_mouse_position()).normalized())
		animation_tree.set('parameters/Idle/blend_position', position.direction_to(get_global_mouse_position()).normalized())
		Attack()

func _process(delta):
	SkillLoop()


func _physics_process(delta):
	MovementLoop(delta)

func SetType(s_type):
	skill_type = s_type
	print("Found: ", str(skill_type))


func SkillLoop():
	if Input.is_action_pressed("Shoot") and can_fire == true:
		can_fire = false
		shooting = true
		speed = 0
		fire_direction = (get_angle_to(get_global_mouse_position())/3.14)*180
		get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position())
		
		
		### This part needs fixing -- need to match SkillType ?? double check
		var skill_type = Server.FetchSkillType("Ice_Spear", get_instance_id())
		## Try debug with prints to get skill type! We are fetching Ice Spear instance.. need skilltype
		print("Found: ", str(skill_type))
		match skill_type:
#		match DataImport.skill_data[selected_skill].SkillType:
			"RangedSingleTargetSkill":
				var skill = load("res://Scenes/RangedSingleTargetSkill.tscn")
				var skill_instance = skill.instance()
				skill_instance.skill_name = selected_skill
				skill_instance.fire_direction = fire_direction
				skill_instance.rotation = get_angle_to(get_global_mouse_position())
				skill_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
				get_parent().add_child(skill_instance)
				
			"RangedAOESkill":
				var skill = load("res://Scenes/RangedAOESkill.tscn")
				var skill_instance = skill.instance()
				skill_instance.skill_name = selected_skill
				skill_instance.position = get_global_mouse_position()
				get_parent().add_child(skill_instance)
				
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true
		shooting = false
		speed = 200

func OnHeal(heal_amount):
	pass


func Attack():
	animation_mode.travel("Melee")
	yield(get_tree().create_timer(0.4), "timeout")
	attacking = false

func MovementLoop(delta):
	if moving == false:
		speed = 0
	else:
		speed += acceleration + delta
		if speed > max_speed:
			speed = max_speed
		movement = position.direction_to(destination) * speed
	
		if position.distance_to(destination) > 10:
			movement = move_and_slide(movement)
			animation_tree.set('parameters/Melee/blend_position', position.direction_to(get_global_mouse_position()).normalized())
			animation_tree.set('parameters/Idle/blend_position', position.direction_to(get_global_mouse_position()).normalized())
			animation_mode.travel("Walk")
		else:
			moving = false
			animation_mode.travel("Idle")

