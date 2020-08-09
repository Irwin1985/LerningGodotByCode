extends Area2D
 
# signals
signal picked
signal hurt


var velocity = Vector2.ZERO
var speed = 350

# touch section
var touch_left = false
var touch_right = false
var touch_up = false
var touch_down = false


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
	# si se pulsa la tecla izq. o se pulsa el boton touch izq.
	if Input.is_action_pressed("ui_left") or touch_left:
		velocity.x = -1
	if Input.is_action_pressed("ui_right") or touch_right:
		velocity.x = 1
	if Input.is_action_pressed("ui_up") or touch_up:
		velocity.y = -1
	if Input.is_action_pressed("ui_down") or touch_down:
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


func _on_Player_body_entered(body):
	if body.is_in_group("enemy"):
		emit_signal("hurt")


func _on_LeftButton_pressed():
	touch_left = true


func _on_LeftButton_released():
	touch_left = false


func _on_RightButton_pressed():
	touch_right = true


func _on_RightButton_released():
	touch_right = false


func _on_UpButton_pressed():
	touch_up = true


func _on_UpButton_released():
	touch_up = false


func _on_BottomButton_pressed():
	touch_down = true


func _on_BottomButton_released():
	touch_down = false
