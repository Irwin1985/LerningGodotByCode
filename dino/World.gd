extends Node2D

var CactusScene = preload("res://CactusTileSet.tscn")


func _ready():
	randomize()


func _on_Timer_timeout():
	$Ground.position.x -= 10
	if $Ground.position.x <= -1024:
		$Ground.position.x += 1024
	


func _on_Dino_jump():
	$Timer.start()
	$CactusSpawner.wait_time = 1 + randi() % 2
	$CactusSpawner.start()


func _on_CactusSpawner_timeout():
	$CactusSpawner.stop()
	var cactus_instance = CactusScene.instance()
	cactus_instance.position = Vector2(1024, 454)
	
	$Ground/CactusContainer.add_child(cactus_instance)
	$CactusSpawner.wait_time = 1 + randi() % 2
