extends Area2D
signal can_fire

export (int) var speed = 200

var velocity = Vector2.ZERO


func _ready():
	OS.center_window()

func start(start_position):
	position = start_position
	

func _process(delta):
	velocity.y = -speed
	position += velocity * delta


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("can_fire")
	queue_free()
