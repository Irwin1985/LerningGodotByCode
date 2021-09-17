extends Area2D



func _on_Brick_body_entered(body: Node) -> void:
	if body.is_in_group("ball"):
		var _rb = body as RigidBody2D
		_rb.linear_velocity = _rb.linear_velocity * -1
		queue_free()
