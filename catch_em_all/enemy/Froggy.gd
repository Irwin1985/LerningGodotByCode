extends KinematicBody2D

export (int) var gravity_power
export (int) var jump_power
export (int) var speed

var velocity = Vector2.ZERO # Vector2(0, 0)

enum {IDLE, BREATHE, JUMP_UP, JUMP_DOWN}
var state
var current_anim
var new_anim


func _ready():
	randomize()
	set_timer_interval()
	# Timer "Jump"
	$JumpTimer.wait_time = rand_range(4, 6)
	$JumpTimer.start()
	transition_to(IDLE)


func transition_to(new_state):
	state = new_state
	match (state):
		IDLE:
			new_anim = "idle"
		BREATHE:
			new_anim = "breathe"
		JUMP_UP:
			new_anim = "jump_up"
		JUMP_DOWN:
			new_anim = "jump_down"


func _process(delta):
	if new_anim != current_anim:
		current_anim = new_anim
		$AnimationPlayer.play(current_anim)

	if not is_on_floor():
		velocity.x = speed
	else:
		velocity.x = 0
	
	$Sprite.flip_h = (speed > 0)

	if not is_on_floor() and velocity.y > 0:
		transition_to(JUMP_DOWN)

	if is_on_floor() and state == JUMP_DOWN:
		transition_to(IDLE)


func _physics_process(delta):
	velocity.y += gravity_power * delta
	#velocity.y = velocity.y + gravity_power * delta
	velocity = move_and_slide(velocity, Vector2.UP)



func set_timer_interval():
	# Timer "Breathe"
	var interval = rand_range(2, 4)
	$Timer.wait_time = interval
	$Timer.start()


# Timer para respirar (breathe)
func _on_Timer_timeout():
	$Timer.stop()
	if state == IDLE:
		transition_to(BREATHE)
	#$AnimationPlayer.play("idle")
	set_timer_interval()


func _on_AnimationPlayer_animation_finished(anim_name):
	# Devolver la transición a IDLE (solo cuando sea "breathe")
	if anim_name == "breathe":
		transition_to(IDLE)


func _on_JumpTimer_timeout():
	$JumpTimer.stop() # apagamos
	if state == IDLE:
		velocity.y = jump_power
		transition_to(JUMP_UP)
		update_speed_direction()

	$JumpTimer.wait_time = rand_range(4, 6)
	$JumpTimer.start()


func update_speed_direction():
	var pulso = bool(randi() % 2) # bool(0) | bool(1)
	if pulso == true:
		speed = speed * 1
	else: #False
		speed = speed * -1

	# resumida
#	speed = speed * 1 if bool(randi() % 2) else speed * -1






