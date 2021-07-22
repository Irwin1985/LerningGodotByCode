extends Area2D


export var object_id = ""


func inspect():
	var history = Global.get_object_by_id(object_id)
	for msg in history:
		OS.alert(msg)
		

