extends Area2D

const MOVE_SPEED = 150.0
const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180
var can_shoot = true
var BulletScene = preload("res://Scenes/Bullet.tscn")
var ExplosionScene = preload("res://Scenes/Explosion.tscn")

func _ready():
	OS.center_window()


func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_key_pressed(KEY_UP):
		direction.y = -1
	if Input.is_key_pressed(KEY_DOWN):
		direction.y = 1
	if Input.is_key_pressed(KEY_RIGHT):
		direction.x = 1
	if Input.is_key_pressed(KEY_LEFT):
		direction.x = -1
	
	if Input.is_key_pressed(KEY_SPACE) and can_shoot:
		shoot()
		
	if direction.length() > 0:
		direction = direction.normalized()
	
	position.x = clamp(position.x, 0, SCREEN_WIDTH)
	position.y = clamp(position.y, 0, SCREEN_HEIGHT)
	
	position += MOVE_SPEED * direction * delta


func shoot():
	can_shoot = false
	var bullet_instance = BulletScene.instance()
	bullet_instance.position = position
	get_parent().add_child(bullet_instance)
	$Timer.start()


func _on_Timer_timeout():
	can_shoot = true
	$Timer.stop()


func _on_Player_area_entered(area):
	if area.is_in_group("asteroid"):
		var explosion_instance = ExplosionScene.instance()
		explosion_instance.position = position
		get_parent().add_child(explosion_instance)
		queue_free()		
