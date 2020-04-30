extends Control

func _ready():
	OS.center_window()



func _on_StartButton_pressed():
	get_tree().change_scene("res://main/Main.tscn")
