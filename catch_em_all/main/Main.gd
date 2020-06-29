extends Node2D

# signals
const BASIC_LEVEL = 5
const BONUS_TIME = 5
export (PackedScene) var Gem
var Cherry = preload("res://gem/Cherry.tscn")

var level = 0
var screensize = Vector2.ZERO
var time_left = 0
var score = 0
onready var GameOverTimer = Timer.new()


func _ready():
	$Froggy.visible = false
	randomize()
	OS.center_window()
	timer_settings()
	$HUD/GameOverLabel.visible = false
	time_left = 30 # OJO: llevar a 30 al terminar la depuración.
	$HUD.update_timer(time_left)
	screensize = get_viewport().get_visible_rect().size
	spawn_gems()
	set_cherry_timer()
	$Froggy.visible = true

func timer_settings():
	GameOverTimer.wait_time = 2
	GameOverTimer.connect("timeout", self, "_onGameOverTimer_timeout")
	add_child(GameOverTimer)


func _onGameOverTimer_timeout():
	get_tree().change_scene("res://menu/Menu.tscn")


func _process(delta):
	update_platform_position()
	if $GemContainer.get_child_count() == 0:
		level += 1
		time_left += BONUS_TIME
		var Audio = AudioStreamPlayer.new()
		Audio.stream = load("res://assets/audio/Level.wav")
		add_child(Audio)
		Audio.play()
		spawn_gems()


func update_platform_position():
	$Platform.position.x = $Froggy.position.x


func spawn_gems():
	for index in range(BASIC_LEVEL + level):
		var Gema = Gem.instance()
		Gema.position = \
		Vector2(rand_range(0, screensize.x), 
			rand_range(0, screensize.y))
		$GemContainer.add_child(Gema)


func _on_GameTimer_timeout():
	time_left -= 1 # time_left = time_left - 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()


func _on_Player_picked(type): # type "gem" | "cherry"
	match type:
		"gem":
			score += 1
			$HUD.update_score(score)
		"cherry":
			time_left += 5
			$HUD.update_timer(time_left)


func game_over():
	$GameTimer.stop()
	$HUD/GameOverLabel.visible = true
	$Player.game_over()
	GameOverTimer.start()


func set_cherry_timer():
	var interval = rand_range(5, 10)
	$CherryTimer.wait_time = interval
	$CherryTimer.start()


func _on_CherryTimer_timeout():
	# 1. apagar el timer ? stop()
	# 2. crear la escena cherry
	# 3. agregar la escena cherry al juego. add_child()
	# 4. reajustar el time_out del timer.
	$CherryTimer.stop()
	var cherry = Cherry.instance()
	cherry.position.x = rand_range(25, 460)
	cherry.position.y = rand_range(25, 700)
	$GemContainer.add_child(cherry)
	set_cherry_timer()


func _on_Player_hurt():
	game_over()
