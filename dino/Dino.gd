extends KinematicBody2D

export (int) var gravity
export (int) var jump

enum {IDLE, RUN, JUMP, DEAD}
var state
var cur_anim
var new_anim
var velocity = Vector2()
var game_begin = false


func _ready():
	OS.center_window()
	transition_to(IDLE)


func _process(delta):
	get_input()


func _physics_process(delta):
	if cur_anim != new_anim:
		cur_anim = new_anim
		$AnimationPlayer.play(new_anim)

	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func get_input():
	var key_jump = Input.is_action_pressed("ui_up")
	if is_on_floor() and key_jump:
		game_begin = true
		velocity.y = -jump
		transition_to(JUMP)

	if game_begin and is_on_floor():
		transition_to(RUN)


func transition_to(new_state):
	state = new_state
	match (state):
		IDLE:
			new_anim = "idle"
		RUN:
			new_anim = "run"
		JUMP:
			new_anim = "jump"
		DEAD:
			new_anim = "dead"

