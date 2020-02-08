extends Node2D

# signals
const BASIC_LEVEL = 5
export (PackedScene) var Gem

var level = 0
var screensize = Vector2.ZERO


func _ready():
	randomize()
	OS.center_window()
	screensize = get_viewport().get_visible_rect().size
	spawn_gems()


func _process(delta):
	if $GemContainer.get_child_count() == 0:
		level += 1
		spawn_gems()



func spawn_gems():
	for index in range(BASIC_LEVEL + level):
		var Gema = Gem.instance()
		Gema.position = \
		Vector2(rand_range(0, screensize.x), 
			rand_range(0, screensize.y))
		$GemContainer.add_child(Gema)
		
