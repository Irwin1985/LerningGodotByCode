extends Area2D


signal player_spacebar

const MOVE_SPEED = 150

var velocity = Vector2.ZERO
var cur_anim = ""
var new_anim = ""

var interactive_object = null

func _ready():
	OS.center_window()
	_animation("Idle")


###########################################
# Player movement
###########################################
func _process(delta):
	if new_anim != cur_anim:
		cur_anim = new_anim
		_animation(cur_anim)

	velocity = Vector2.ZERO
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x = 1
		
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x = -1
		
	if Input.is_key_pressed(KEY_UP):
		velocity.y = -1

	if Input.is_key_pressed(KEY_DOWN):
		velocity.y = 1
		
	if Input.is_key_pressed(KEY_SPACE):
		emit_signal("player_spacebar", interactive_object)
	
	$Sprite.flip_h = velocity.x < 0
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * MOVE_SPEED
		_animation("Run")
	else:
		_animation("Idle")
	
	position += velocity * delta

func _animation(state):
	new_anim = state
	$AnimationPlayer.play(state)


func _on_Player_area_entered(area):
	if area.is_in_group("interactive_object"):
		interactive_object = area # guardamos la referencia del objeto


func _on_Player_area_exited(area):
	if area.is_in_group("interactive_object"):
		interactive_object = null
