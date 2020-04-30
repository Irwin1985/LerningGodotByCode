extends Area2D
export (int) var speed
var velocity = Vector2.ZERO


func start(pos, dir):
	position = pos
	velocity.x = speed * dir
	$Sprite.flip_h = (dir == 1)


func _process(delta):
	position += velocity * delta


func _on_Bullet_area_entered(area):
	set_process(false)
	$Sprite.frame = 1
	yield(get_tree().create_timer(0.1), "timeout")
	queue_free()
