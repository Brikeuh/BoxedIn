extends CharacterBody2D

enum movementTypes{VERTICAL, HORIZONTAL, RANDOM, CHASE}
@export var movementType: movementTypes

var rng = RandomNumberGenerator.new()
var randDelay = 0
var vertRan = 1
var horiRan = 1

const max_speed = 100
const accel = 100000

var posSwitch = 1

func _ready():
	add_to_group("BoxEnemy")

func _physics_process(delta):
	box_movement(movementType, delta)
	

func _process(_delta):
	randDelay -= 1
	if randDelay <= 0:
		vertRan = rng.randi_range(-1,1)
		horiRan = rng.randi_range(-1,1)
		randDelay = 100

func box_movement(option, delta):
	match option:
		0: # Vertical
			position += transform.y * max_speed * delta * posSwitch
		1: # Horizontal
			position += transform.x * max_speed * delta * posSwitch
		2: # Random 
			position += transform.y * max_speed * delta * vertRan * posSwitch
			position += transform.x * max_speed * delta * horiRan * posSwitch
		3: # Chase future implementation needed
			pass
		_:
			pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("Terrain"):
		posSwitch = posSwitch * -1
