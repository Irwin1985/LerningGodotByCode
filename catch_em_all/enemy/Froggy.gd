extends Area2D
var can_jump = false
var final_pos = 0

func _ready():
	OS.center_window()
	randomize()
	frog_timeout()
	frog_jump_timeout()


func _process(delta):
	if can_jump and position.x < final_pos:
		position += Vector2(1, 0) * delta
	else:
		can_jump = false
		final_pos = 0


func frog_timeout():
	$Timer.wait_time = rand_range(1, 5)
	$Timer.start()


func frog_jump_timeout():
	$JumpTimer.wait_time = rand_range(1, 5)
	$JumpTimer.start()



func _on_Timer_timeout():
	$AnimationPlayer.play("idle")
	$Timer.stop()
	frog_timeout()


func _on_JumpTimer_timeout():
	can_jump = true
	final_pos = position.x + 400
	$JumpTimer.stop()
	frog_jump_timeout()






