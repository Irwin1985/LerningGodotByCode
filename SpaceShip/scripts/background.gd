extends Sprite
const SCREEN_WIDTH = 320
var scroll_speed = 30.0

func _process(delta):
	position += Vector2(-scroll_speed * delta, 0.0)
	if position.x <= -SCREEN_WIDTH:
		position.x += SCREEN_WIDTH

