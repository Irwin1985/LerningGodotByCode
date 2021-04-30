extends Area2D

const MOVE_SPEED = 150.0
const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180

var shot_scene = preload("res://scenes/shot.tscn")
var explosion_scene = preload("res://scenes/explosion.tscn")
var can_shoot: bool = true

signal destroyed
signal hitted

func _process(delta):
	var input_dir:Vector2 = Vector2.ZERO
	if Input.is_key_pressed(KEY_UP):
		input_dir.y -= 1.0
	if Input.is_key_pressed(KEY_DOWN):
		input_dir.y += 1.0
	if Input.is_key_pressed(KEY_LEFT):
		input_dir.x -= 1.0
	if Input.is_key_pressed(KEY_RIGHT):
		input_dir.x += 1.0

	if Input.is_key_pressed(KEY_SPACE) and can_shoot:
		can_shoot = false
		var stage_node = get_parent()
		
		var shot_instance = shot_scene.instance()
		shot_instance.position = position + Vector2(9, -5)
		stage_node.add_child(shot_instance)

		var shot_instance_2 = shot_scene.instance()
		shot_instance_2.position = position + Vector2(9, 5)
		stage_node.add_child(shot_instance_2)

		$reload_timer.start()

	# normalizar el vector
	if input_dir.length() > 0:
		input_dir = input_dir.normalized()

	position += (delta * MOVE_SPEED) * input_dir

	position.x = clamp(position.x, 0.0, SCREEN_WIDTH)
	position.y = clamp(position.y, 0.0, SCREEN_HEIGHT)


func _on_reload_timer_timeout():
	can_shoot = true


func _on_player_area_entered(area):
	if area.is_in_group("asteroid"):
		emit_signal("hitted")
		area.explode()
		#queue_free()
		#var explosion_instance = explosion_scene.instance()
		#explosion_instance.position = position
		#get_parent().add_child(explosion_instance)
		#emit_signal("destroyed")


func explode():
	queue_free()
	var explosion_instance = explosion_scene.instance()
	explosion_instance.position = position
	get_parent().add_child(explosion_instance)
	emit_signal("destroyed")
