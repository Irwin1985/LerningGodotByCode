extends StaticBody2D

export var speed = 20

func _process(delta):
	pass
	#position += Vector2(speed * -1, 0)



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
