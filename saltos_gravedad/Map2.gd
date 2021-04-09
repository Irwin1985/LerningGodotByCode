extends Node2D
export (PackedScene) var Hongo

func _ready():
	$Items.hide()
	spawn_items()


func spawn_items():
	for cell in $Items.get_used_cells():
		var EscenaHongo = Hongo.instance() # creamos la instancia de Hongo
		EscenaHongo.position = $Items.map_to_world(cell) * 1.5 + $Items.cell_size / 2
		add_child(EscenaHongo)

