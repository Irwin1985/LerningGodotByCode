extends Node2D
export (PackedScene) var Bullet


func _on_SpaceShip_fired(_position):
	var bullet = Bullet.instance()
	bullet.connect("can_fire", self, "_on_Bullet_can_fire")
	
	bullet.start(_position)
	add_child(bullet)

func _on_Bullet_can_fire():
	$SpaceShip.can_fire = true
