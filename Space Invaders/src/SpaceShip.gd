extends Area2D

signal fired


export (int) var speed = 200
var velocity: Vector2 = Vector2.ZERO
var can_fire = true

func _ready():
	OS.center_window()


func _process(delta):
	velocity.x = 0
	if !$RayCastLeft.is_colliding() and Input.is_action_pressed("ui_left"):
		velocity.x = speed * -1
	elif !$RayCastRight.is_colliding() and Input.is_action_pressed("ui_right"):
		velocity.x = speed

	position.x += velocity.x * delta

	# Fire section
	if Input.is_action_pressed("fire") and can_fire: # z or space
		can_fire = false
		emit_signal("fired", $BulletPosition.global_position)
