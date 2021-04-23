extends Area2D

const MOVE_SPEED = 100.0
var ExplosionScene = preload("res://Scenes/Explosion.tscn")



func _process(delta):
	position -= Vector2(MOVE_SPEED * delta, 0)
	if position.x < -100:
		queue_free()



func _on_Asteroid_area_entered(area):
	if area.is_in_group("bullet"):
		var explosion_instance = ExplosionScene.instance()
		explosion_instance.position = position
		get_parent().add_child(explosion_instance)
		queue_free()
		
