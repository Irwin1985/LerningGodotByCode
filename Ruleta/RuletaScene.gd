extends Node2D


export (int) var _roullete_rounds: int = 5
var _current_round: int = 0
export (int) var _roullete_speed: int = 100 # porcentaje
var _can_move_roullete: bool = false
export (float) var _rate: float = 20.0
var _selected_area: Area2D = null


func _process(delta: float) -> void:
	if _can_move_roullete:
		if _roullete_speed > 0 and $Timer.is_stopped():
			_roullete_speed -= 1
		if _roullete_speed > 0:
			_speed_up_roullete(delta)


func _speed_up_roullete(delta: float):
	$SpriteRuleta.rotation_degrees += _roullete_speed * delta


func _on_Button_pressed() -> void:
	_start_roullete()


func _start_roullete() -> void:	
	for node in $SpriteRuleta.get_children():
		for child in node.get_children():
			child.disabled = false
		#node.CollisionPolygon2D.disabled = false
		
	_can_move_roullete = true
	$Timer.start()


func _on_Timer_timeout() -> void:
	_current_round += 1
	_roullete_speed = _roullete_speed - (_rate * _roullete_speed) / 100
	if _current_round >= _roullete_rounds:
		$Timer.stop()
		print("Area ganadora: ", _selected_area.name)


func _on_AreaManecilla_area_entered(area: Area2D) -> void:
	_selected_area = area
