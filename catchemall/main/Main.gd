extends Node2D

export (PackedScene) var Gem
export (PackedScene) var Powerup
export (int) var playtime

var level = 0
var score = 0
var time_left = 0
var screensize
var playing = false


func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	$Player.hide()
	$HUD.update_score(score)
	$HUD.update_timer(time_left)


func _process(delta):
	if playing and $CherryContainer.get_child_count() == 0:
		level += 1
		time_left += 5
		spawn_cherries()
		$PowerupTimer.wait_time = rand_range(3, 6)
		$PowerupTimer.start()


func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start()
	spawn_cherries()


func spawn_cherries():
	$LevelSound.play()
	for i in range(4 + level):
		var c = Gem.instance()
		c.screensize = screensize
		c.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))
		$CherryContainer.add_child(c)


func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()


func _on_Player_pickup(type):
	match type:
		"gem":
			score += 1
			$CherrySound.play()
			$HUD.update_score(score)
		"powerup":
			time_left += 5
			$PowerupSound.play()
			$HUD.update_timer(time_left)


func _on_Player_hurt():
	game_over()


func game_over():
	playing = false
	$GameTimer.stop()
	for cherry in $CherryContainer.get_children():
		cherry.queue_free()
	$HUD.show_game_over()
	$Player.die()
	$EndSound.play()


func _on_PowerupTimer_timeout():
	var p = Powerup.instance()
	p.screensize = screensize
	p.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))
	add_child(p)
