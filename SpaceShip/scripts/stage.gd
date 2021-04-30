extends Node2D

var is_game_over: bool = false
var asteroid = preload("res://scenes/asteroid.tscn")
var player_health:int = 6

const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180
var score = 0


func _ready():
	OS.center_window()
	$player.connect("destroyed", self, "_on_player_destroyed")
	$player.connect("hitted", self, "_on_player_hitted")
	$spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	if is_game_over and Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene("res://scenes/stage.tscn")

func _on_player_destroyed():
	$ui/retry.show()
	is_game_over = true


func _on_player_hitted():
	player_health -= 1
	if player_health <= 0:
		$player.explode()
	$ui/lives.text = "Lives: " + str(player_health)


func _on_spawn_timer_timeout():
	var asteroid_instance = asteroid.instance()
	asteroid_instance.position = Vector2(SCREEN_WIDTH + 8, rand_range(0, SCREEN_HEIGHT))
	asteroid_instance.connect("score", self, "_on_player_score")
	add_child(asteroid_instance)

func _on_player_score():
	score += 1
	$ui/score.text = "Score: " + str(score)
	if score % 10 == 0:
		$spawn_timer.wait_time = $spawn_timer.wait_time / 1.10
