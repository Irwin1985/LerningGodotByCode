extends Area2D



func _on_Hongo_body_entered(body):
	queue_free() # elimina el objeto (nodo)
