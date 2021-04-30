extends Navigation2D

var start_point = Vector2()
var end_point = Vector2()
var path = []

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			start_point = event.position
		elif event.button_index == BUTTON_RIGHT:
			end_point = event.position

func _process(delta):
	path = get_simple_path(start_point, end_point, false)
	update()


func _draw():
	for point in path:
		draw_circle(point, 3, Color(1, 1, 1))
	draw_polyline(path, Color(1, 1, 1), 3.0, true)


func _ready():
	OS.center_window()

