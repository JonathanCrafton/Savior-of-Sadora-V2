extends StaticBody2D
func _ready():
	pass # Replace with function body.
#func _process(delta):
#	pass



func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		if body.hp != body.MAX_HP:
			body.heal()
			queue_free()
			print(body.hp)
