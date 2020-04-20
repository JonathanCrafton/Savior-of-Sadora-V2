extends MarginContainer


func _process(delta):
	var hp = get_tree().root.get_node("Level1").get_node("Player_Mage").hp
	$HBoxContainer/VBoxContainer/HP.text = "  " + str(hp)
