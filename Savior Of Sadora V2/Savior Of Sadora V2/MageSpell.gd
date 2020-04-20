extends Area2D

const SPEED = 200
var velocity = Vector2()
var direction = 1

func _ready():
	pass # Replace with function body.

func set_spell_dir(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	

func _process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("shoot")
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_MageSpell_body_entered(body):
	if "Enemy" in body.name:
		body.queue_free()
	queue_free()
