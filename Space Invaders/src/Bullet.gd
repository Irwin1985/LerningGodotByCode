extends Area2D
signal canfire

export (int) var speed = 200
var velocity = Vector2.ZERO


func _ready():
	OS.center_window()

# recibe la posición inicial para la bala.
func start(start_position):
	position = start_position


func _process(delta):
	velocity.y = -speed
	position += velocity * delta


func _on_VisibilityNotifier2D_screen_exited():
	# ya sabemos que hemos abandonado la escena.
	emit_signal("canfire")
	queue_free()
