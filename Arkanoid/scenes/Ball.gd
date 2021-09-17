extends RigidBody2D


func _ready() -> void:
	mode = RigidBody2D.MODE_CHARACTER
	bounce = 1
	friction = 0
	gravity_scale = 0
	linear_damp = 0.0
	angular_damp = 0.0
	linear_velocity = Vector2(250, -250)

