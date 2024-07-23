extends CharacterBody2D

#@export var Projectile : PackedScene
@onready var Projectile = preload("res://projectile.tscn")

const max_speed = 300
const accel = 100000
const friction = 600

var input = Vector2.ZERO
var shootCooldown = 0


## Called every frame. 
func _physics_process(delta):
	player_movement(delta)
	move_and_slide()

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Attack") && shootCooldown <= 0:
		shoot(delta)
	shootCooldown -=1

## Receive Movement related Inputs
func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized()

## Generate movement
func player_movement(delta):
	input = get_input()
	if input == Vector2.ZERO:
		#instant stop
		velocity = Vector2.ZERO
	else:
		# player will move at a set maximum speed in any direction
		velocity = (input * accel * delta)
		velocity = velocity.limit_length(max_speed)

## Basic projectile attack function
func shoot(delta):
	var p = Projectile.instantiate()
	owner.add_child(p)
	p.transform = $Muzzle.global_transform
	shootCooldown = 50

## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
