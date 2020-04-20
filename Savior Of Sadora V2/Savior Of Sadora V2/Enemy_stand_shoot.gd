extends StaticBody2D
var hp = 2

var delay = 150

const FIREBALL = preload("res://EnemyFireball.tscn")

func _ready():
	pass # Replace with function body.

func _process(delta):
	var fireball = FIREBALL.instance()
	delay -= 1
	if delay == 0:
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
			delay = 150
