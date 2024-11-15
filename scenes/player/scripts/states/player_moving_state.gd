extends State
class_name PlayerMoving

@export var movespeed := int(100)

var player : CharacterBody2D
var shadow_flip = 4 # the offset value that the shadow has to match the player when the player flips when turning to the left
@export var animator : AnimationPlayer
@export var sprite_2d = Sprite2D
@export var shadow = Sprite2D
@onready var muzzle = $"../../Muzzle"

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	animator.play("walk")
	
func Update(delta : float):
	var input_dir = Input.get_vector("left", "right", "up", "down").normalized()
	Move(input_dir)
		
	if Input.is_action_pressed("attack"):
		Transition("Attack")
	
func Move(input_dir : Vector2):
	if input_dir.y != 0:
		player.velocity = input_dir * movespeed * 0.3
	else:
		player.velocity = input_dir * movespeed
		
	if input_dir.x == -1:
		sprite_2d.flip_h = true
		shadow.offset.x = shadow_flip
		if muzzle.position.x > 0:
			muzzle.position.x *= -1
	elif input_dir.x == 1:
		sprite_2d.flip_h = false
		shadow.offset.x = 0
		if muzzle.position.x < 0:
			muzzle.position.x *= -1
		
	player.move_and_slide()

	if(input_dir.length() <= 0):
		Transition("idle")
		
func Transition(newstate : String):
	state_transition.emit(self, newstate)
