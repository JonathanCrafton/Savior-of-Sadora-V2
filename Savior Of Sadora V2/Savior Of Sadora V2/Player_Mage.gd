extends KinematicBody2D
# Variables
const UP = Vector2(0,-1)
var motion = Vector2()
export var speed = 250
export var gravity = 35
export var jump_force = -550
var DAMAGE = 1
var hitstun = 0
var MAX_HP = 4
var hp = 4
var TYPE = "Player"
var shoot_buffer = 0

var is_dead = false


const SPELL = preload("res://MageSpell.tscn")

func _physics_process(delta):
	if hp == 0:
		dead()
	
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
			var spell = SPELL.instance()
			
			if sign($Position2D.position.x) == 1:
				spell.set_spell_dir(1)
			else:
				spell.set_spell_dir(-1)
				
			get_parent().add_child(spell)
			spell.position = $Position2D.global_position
			shoot_buffer = 40
			
			
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = jump_force
				
		motion = move_and_slide(motion, UP)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					damage()
		
		if hitstun > 0:
			hitstun -= 1
func dead():
	is_dead = true
	motion = Vector2(0,0)
	get_tree().change_scene("res://GameOver.tscn")
	
func damage():
	if hitstun == 0:
		hp -= 1
		print(hp)
		hitstun = 20

func heal():
	hp += 1
