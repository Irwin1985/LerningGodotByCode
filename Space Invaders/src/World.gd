extends Node2D
export (PackedScene) var Bullet


func _ready():
	OS.center_window()



func _on_SpaceShip_fired(bullet_position):
	#1. Crear una instancia de la bala
	var bullet = Bullet.instance()
	
	bullet.connect("canfire", self, "_on_Bullet_canfire")
	
	#2. Decirle a la bala desde donde se dibujará.
	bullet.start(bullet_position)
	#3. add_child()
	add_child(bullet)


func _on_Bullet_canfire():
	$SpaceShip.can_fire = true
