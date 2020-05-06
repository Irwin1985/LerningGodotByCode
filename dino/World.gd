extends Node2D

var Ground = preload("res://Ground.tscn")
var ground_position = 0

func _ready():
	spawn_ground(2)


func spawn_ground(how_many):
	for i in how_many:
		var ground = Ground.instance()
		var color: Color = Color(255, 0, 0, 1)
		if i == 1:
			color = Color(0, 0, 255, 1)
		ground.position = $GroundPosition.position
		if ground_position == 0:
			ground.position.x = $GroundPosition.position.x
		else:
			ground.position.x = ground_position
		ground_position += 1024
		
		print(ground_position)
		ground.get_node("Sprite").modulate = color
		ground.connect("ground_exited", self, "on_ground_exited", [], CONNECT_DEFERRED)
		$GroundContainer.add_child(ground)



func on_ground_exited(ground: StaticBody2D):
	ground.call_deferred("queue_free")
	ground_position -= 1024
	spawn_ground(1)


func _on_Timer_timeout():
	for ground in $GroundContainer.get_children():
		ground.position.x -= 10
