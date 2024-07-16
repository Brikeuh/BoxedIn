extends CharacterBody2D

const max_speed = 300
const accel = 1000
const friction = 600

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)
	move_and_slide()

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized()

func player_movement(delta):
	input = get_input()
	if input == Vector2.ZERO:
		#instant stop
		velocity = Vector2.ZERO
		#character will slow down gradually
		#if velocity.length() > (friction * delta):
			#velocity -= velocity.normalized() * friction * delta
		#else:
			#velocity = Vector2.ZERO
	elif velocity.length() < max_speed:
		# gradually speeds character up until max speed is reached
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
	else:
		# player can now change direction (with no sliding) after reaching max speed
		# stops when the player stops
		velocity = (input * accel*100 * delta)
		velocity = velocity.limit_length(max_speed)

## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
	
