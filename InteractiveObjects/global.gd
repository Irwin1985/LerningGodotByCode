extends Node


var object_history: Dictionary = {
	"object_1_backyard": [
		"Este libro contiene todos los hechizos de este bosque...",
		"Si tuviera espacio suficiente, me lo llevaría sin dudar...",
		"Por ahora solo que toca seguir explorando..."
	],
	"object_2_backyard": [
		"Este tomate me parece extraño...",
		"Se ve comestible pero es el el único en este lugar...",
		"Prefiero dejarlo allí donde está..."
	],
	"object_3_backyard": [
		"Esta es la pócima de la bruja del bosque...",
		"Tengo ganas de cogerla pero me da un poco de miedo...",
		"Aunque la necesito para librarme de sus conjuros...."
	],		
}


func get_object_by_id(key: String) -> Array:
	if object_history.has(key):
		return object_history[key]
	else:
		return []


