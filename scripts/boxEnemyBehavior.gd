extends CharacterBody2D

enum movementTypes{VERTICAL, HORIZONTAL, RANDOM, CHASE}
@export var movementType: movementTypes

@onready var navigationAgent: NavigationAgent2D = $NavigationAgent2D
@export var targetToChase: CharacterBody2D
var rng = RandomNumberGenerator.new()

const max_speed = 100
const accel = 100000
const friction = 600

var posSwitch = 1

func _ready():
	add_to_group("BoxEnemy")

func _physics_process(delta):
	box_movement(movementType, delta)

func box_movement(option, delta):
	match option:
		0: # Vertical
			position += transform.y * max_speed * delta * posSwitch
		1: # Horizontal
			position += transform.x * max_speed * delta * posSwitch
		2: # Random 
			pass
		3: # Chase future implementation needed
			navigationAgent.target_position = targetToChase.global_position
			velocity = global_position.direction_to(navigationAgent.get_next_path_position()) * max_speed * delta
		_:
			pass
	#velocity = (input * accel * delta)
	#velocity = velocity.limit_length(max_speed)

func _on_area_2d_body_entered(body):
	if body.is_in_group("Terrain"):
		posSwitch = posSwitch * -1
