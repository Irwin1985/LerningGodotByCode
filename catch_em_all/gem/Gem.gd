extends Area2D


func _ready():
	$Tween.interpolate_property($AnimatedSprite, 
		'scale', 
		$AnimatedSprite.scale, $AnimatedSprite.scale * 3, 
		0.3,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT)

func pickup():
	$Tween.start()




func _on_Tween_tween_completed(object, key):
	call_deferred("queue_free")
