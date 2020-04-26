extends Node2D

func _on_Player_state_changed(new_animation):
	$Control/LabelState.text = new_animation


func _on_Player_shoot(bullet, pos, dir):
	var b = bullet.instance()
	b.start(pos, dir)
	add_child(b)


func _on_ButtonDead_pressed():
	$Player.dead()
