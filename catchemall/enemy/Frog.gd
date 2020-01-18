extends Area2D
var screensize = Vector2(480, 720)
const SPEED = 100
var velocity = Vector2.ZERO
var can_move = false

func _ready():
	OS.center_window()
	$AnimationPlayer.play("idle")
	$JumpTimer.wait_time = rand_range(3, 6)
	$JumpTimer.start()


func _process(delta):
	if can_move:
		position += Vector2(SPEED * delta, 0)


func _on_IdleTimer_timeout():
	$AnimationPlayer.play("idle")


func _on_JumpTimer_timeout():
	can_move = true
	$AnimationPlayer.play("jump")
	$JumpTimer.wait_time = rand_range(3, 6)
	$JumpTimer.start()


func _on_AnimationPlayer_animation_finished(anim_name):
	can_move = false


func _on_AnimationPlayer_animation_started(anim_name):
	pass # Replace with function body.
