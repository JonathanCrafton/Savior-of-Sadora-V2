extends KinematicBody2D
# Variables
const UP = Vector2(0,-1)
var motion = Vector2()
export var speed = 250
export var gravity = 35
export var jump_force = -550
var DAMAGE = 1
var hitstun = 0
var MAX_HEALTH = 4
var current_health = 3
var TYPE = "Player"
var shoot_buffer = 0

var is_dead = false


const FIREBALL = preload("res://MageSpell.tscn")

func _physics_process(delta):
	if is_dead == false: 
		motion.y += gravity
		shoot_buffer -= 1
		if shoot_buffer < 0:
			shoot_buffer = 0
		if Input.is_action_pressed("ui_right"):
			motion.x = speed
			get_node("Sprite").set_flip_h(false)
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
			
		elif Input.is_action_pressed("ui_left"):
			motion.x = -speed
			get_node("Sprite").set_flip_h(true)
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
			
		else:
			motion.x = 0
			
		if Input.is_action_just_pressed("ui_select") && shoot_buffer == 0:
			var fireball = FIREBALL.instance()
			
			if sign($Position2D.position.x) == 1:
				fireball.set_spell_dir(1)
			else:
				fireball.set_spell_dir(-1)
				
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
			shoot_buffer = 40
			
			
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = jump_force
				
		motion = move_and_slide(motion, UP)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					dead()
		
func dead():
	is_dead = true
	motion = Vector2(0,0)
	$Timer.start()
	


func _on_Timer_timeout():
	queue_free()
