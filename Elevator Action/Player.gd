extends KinematicBody2D
export (int) var speed
export (int) var gravity
export (int) var jump
signal state_changed
signal shoot
export (PackedScene) var Bullet

var velocity = Vector2()
enum {IDLE, MOVE, JUMP, DUCK, DEAD}
var state
var anim
var new_anim

func _ready():
	OS.center_window()
	$SpriteFire.visible = false
	$SpriteDead.visible = false
	change_state(IDLE)


func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			new_anim = "idle"
		MOVE:
			new_anim = "walk"
		JUMP:
			new_anim = "jump"
		DUCK:
			new_anim = "duck"
		DEAD:
			new_anim = "dead"
	emit_signal("state_changed", new_anim)
func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	if new_anim != anim:
		anim = new_anim
		$AnimationPlayer.play(anim)
	velocity = move_and_slide(velocity, Vector2.UP)

func get_input():
	if state != DEAD:
		velocity.x = 0

		if Input.is_action_pressed("ui_right"):
			if state != DUCK:
				velocity.x += speed
			$Sprite.flip_h = true

		if Input.is_action_pressed("ui_left"):
			if state != DUCK:
				velocity.x -= speed
			$Sprite.flip_h = false

		if state == DUCK and Input.is_action_pressed("ui_up"):
			change_state(IDLE)

		if state == IDLE and Input.is_action_pressed("ui_down"):
			change_state(DUCK)

		if is_on_floor() and Input.is_action_just_pressed("jump"):
			velocity.y = jump
			$SoundNode/JumpSound.play()
			change_state(JUMP)

		if state == IDLE and velocity.x != 0:
			change_state(MOVE)

		if state == MOVE and velocity.x == 0:
			change_state(IDLE)

		if state in [IDLE, MOVE] and !is_on_floor():
			change_state(JUMP)

		if state == JUMP and is_on_floor():
			change_state(IDLE)

		if Input.is_action_just_pressed("fire"):
			shoot()
	else:
		#is dead
		pass


func dead():
	$Sprite.visible = false
	$SpriteFire.visible = false
	$SpriteDead.visible = true
	change_state(DEAD)
	$SoundNode/DeadSound.play()


func shoot():
	$SoundNode/ShootSound.play()
	var direction = 0
	$SpriteFire.flip_h = $Sprite.is_flipped_h()
	if $SpriteFire.is_flipped_h():
		direction = 1
		if state == JUMP:
			$BulletPosition.position = Vector2(13, 13)
			$SpriteFire.visible = false
		elif state == DUCK:
			$SpriteFire.visible = true
			$SpriteFire.offset = Vector2(8, 9)
			$BulletPosition.position = Vector2(-13, 10)
		else:
			$BulletPosition.position = Vector2(13, -4.5)
			$SpriteFire.offset = Vector2(8, -2)
	else:
		direction = -1
		if state == JUMP:
			$BulletPosition.position = Vector2(-13, 13)
			$SpriteFire.visible = false
		elif state == DUCK:
			$SpriteFire.visible = true
			$SpriteFire.offset = Vector2(-8, 9)
			$BulletPosition.position = Vector2(-13, 10)
		else:
			$BulletPosition.position = Vector2(-13, -4.5)
			$SpriteFire.offset = Vector2(-8, -2)

	emit_signal("shoot", Bullet, $BulletPosition.global_position, direction)
	if state != JUMP:
		$SpriteFire.visible = true
		$SpriteFire.frame = 0
		yield(get_tree().create_timer(0.1), "timeout")
		$SpriteFire.frame = 1
		yield(get_tree().create_timer(0.1), "timeout")
		$SpriteFire.visible = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fire":
		$SpriteFire.visible = false


func _on_DeadSound_finished():
	$AnimationPlayer.stop()
	$SpriteDead.frame = 0
	yield(get_tree().create_timer(0.3), "timeout")
	$SpriteDead.visible = false
