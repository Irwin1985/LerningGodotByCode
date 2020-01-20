extends Area2D

signal hurt
signal pickup

export (int) var speed = 350
var velocity = Vector2.ZERO
var screensize = Vector2(480, 720)

func _ready():
	OS.center_window()

func _process(delta):
	get_input()
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)

	if velocity.length() > 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.animation = "idle"


func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed
	if Input.is_action_pressed("ui_down"):
		velocity.y = speed
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = "idle"

func die():
	$AnimatedSprite.animation = "hurt"
	set_process(false)

func _on_Player_area_entered(area):
	if area.is_in_group("gems"):
		area.pickup()
		emit_signal("pickup", "gem")

	if area.is_in_group("powerups"):
		area.pickup()
		emit_signal("pickup", "powerup")

	if area.is_in_group("enemy"):
		emit_signal("hurt")
		die()
