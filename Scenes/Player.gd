extends KinematicBody2D

var speed = 350
var move_direction = Vector2(0,0)

func _physics_process(delta):
	MovementLoop()

func _process(delta):
	AnimationLoop()


func MovementLoop():
	move_direction.x = int(Input.is_action_pressed("d")) - int(Input.is_action_pressed("a"))
	move_direction.y = (int(Input.is_action_pressed("s")) - int(Input.is_action_pressed("w"))) / float(2)
	var motion = move_direction.normalized() * speed
	move_and_slide(motion)


func AnimationLoop():
	var anim_direction = "S"
	var anim_mode = "Idle"
	var animation
	match move_direction:
		Vector2(-1,0):
			anim_direction = "W"
		Vector2(1,0):
			anim_direction = "E"
		Vector2(0,0.5):
			anim_direction = "S"
		Vector2(0,-0.5):
			anim_direction = "N"
		Vector2(-1,-0.5):
			anim_direction = "NW"
		Vector2(-1,0.5):
			anim_direction = "SW"
		Vector2(1,-0.5):
			anim_direction = "NE"
		Vector2(1,0.5):
			anim_direction = "SE"
	if move_direction != Vector2(0,0):
		anim_mode = "Walk"
	else:
		anim_mode = "Idle"
	animation = anim_mode + "-" +  anim_direction
	get_node("AnimationPlayer").play(animation)
