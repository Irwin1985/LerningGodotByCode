extends KinematicBody2D

var speed = 150
var velocity = Vector2(0, 0)
var gravity = 750
var jump = -300

enum {IDLE, RUN, JUMP, DEAD}

var state
var current_animation
var new_animation


func _ready():
	OS.center_window()
	transition_to(IDLE)


func _physics_process(delta):
	if current_animation != new_animation:
		current_animation = new_animation
		$AnimationPlayer.play(current_animation)

	velocity.y += gravity * delta
	
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x = velocity.x + speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = jump
		transition_to(JUMP)

	if state == IDLE and velocity.x != 0:
		transition_to(RUN)
	
	if state == RUN and velocity.x == 0:
		transition_to(IDLE)
	
	if state in [IDLE, RUN] and !is_on_floor():
		transition_to(JUMP)

	if state == JUMP and is_on_floor():
		transition_to(IDLE)
	

	velocity = move_and_slide(velocity, Vector2.UP)


func transition_to(new_state):
	state = new_state
	match state:
		IDLE:
			new_animation = "idle"
		RUN:
			new_animation = "run"
		JUMP:
			new_animation = "jump"
		DEAD:
			new_animation = "dead"
