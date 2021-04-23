extends Node2D
var AsteroidScene = preload("res://Scenes/Asteroid.tscn")
const SCREEN_HEIGHT = 180

func _on_AsteroidSpawn_timeout():
	var asteroid_instance = AsteroidScene.instance()
	var y = rand_range(0, SCREEN_HEIGHT)
	var x = $AsteroidPosition.position.x
	asteroid_instance.position = Vector2(x, y)
	add_child(asteroid_instance)
	
