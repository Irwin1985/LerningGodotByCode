extends Node2D


func _ready():
	OS.center_window()



func _on_Player_player_spacebar(area):
	if area != null:
		area.inspect()
