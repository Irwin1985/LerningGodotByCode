extends Area2D

func pickup():
	call_deferred("queue_free")

