extends Area2D
const FIRE_VELOCITY = Vector2(-200, 100)
var velocity = FIRE_VELOCITY
var direction = -1
const GRAVITY = 50




func _ready():
	pass # Replace with function body.

func set_spell_dir(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	translate(velocity * delta)
	$AnimatedSprite.play("shoot")
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_EnemyFireball_body_entered(body):
	if "Player" in body.name:
		body.damage()
	queue_free()
