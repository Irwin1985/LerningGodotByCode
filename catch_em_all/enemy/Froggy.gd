extends Area2D
# 1. ajustar el timer (random, 5, 8)
# 2. reproducir la animación de Froggy

func _ready():
	set_timer_interval()


func set_timer_interval():
	var interval = rand_range(4, 6)
	$Timer.wait_time = interval
	$Timer.start()


func _on_Timer_timeout():
	$Timer.stop()
	$AnimationPlayer.play("idle")
	set_timer_interval()
