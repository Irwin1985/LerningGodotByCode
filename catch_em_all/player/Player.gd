extends Area2D
 
# signals
signal picked


var velocity = Vector2.ZERO
var speed = 350


func _ready():
	OS.center_window()


func _process(delta):
	get_input()
	position += velocity * delta
	
	position.x = clamp(position.x, 0, 480)
	position.y = clamp(position.y, 0, 720)

	process_animations()


func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed


func process_animations():
	if velocity.length() != 0:
		$AnimatedSprite.play("run")
		if velocity.x < 0:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("idle")


func _on_Player_area_entered(area):
	if area.is_in_group("gem"):
		$GemAudio.play()
		emit_signal("picked", "gem")
	elif area.is_in_group("cherry"):
		#$GemAudio.play()<- reproducir el audio del powerup
		emit_signal("picked", "cherry")

	if area.has_method("pickup"):
		area.pickup()



func game_over():
	set_process(false)
	$AnimatedSprite.animation = "hurt"






