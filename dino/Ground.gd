extends StaticBody2D
signal ground_exited


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("ground_exited", self)
