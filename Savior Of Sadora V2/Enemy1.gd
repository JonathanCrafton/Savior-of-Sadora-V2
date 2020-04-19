extends KinematicBody2D

const UP = Vector2(0,-1)
var motion = Vector2()
export var speed = 100
export var gravity = 35
var TYPE = "ENEMY"
var direction = 1


func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	motion.y += gravity
	motion.x = speed * direction
	motion = move_and_slide(motion, UP)
	
	if direction == 1:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
	
	if is_on_wall():
		direction = direction * -1
	
	if get_slide_count() > 0:
		for i in range (get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead()
	
