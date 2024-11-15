extends CharacterBody2D

#@export var Projectile : PackedScene
@onready var Projectile = preload("res://scenes/player/projectile.tscn")
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var shadow = $Shadow

const max_speed = 300
const accel = 5000
const friction = 600

var input = Vector2.ZERO
var shootCooldown = 0


## Called every frame. 
func _physics_process(delta):
	player_movement(delta)
	move_and_slide()

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("attack") && shootCooldown <= 0:
		shoot()
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
		animation_player.speed_scale = 1
	elif input.y != 0:
		velocity = (input * accel*0.5 * delta)
		velocity = velocity.limit_length(max_speed)
		animation_player.speed_scale = 1.5
	else:
		if Input.is_action_pressed("sprint"):
			velocity = (input * accel*2 * delta)
			velocity = velocity.limit_length(max_speed)
			animation_player.speed_scale = 2
		else:
			# player will move at a set maximum speed in any direction
			velocity = (input * accel * delta)
			velocity = velocity.limit_length(max_speed)
			animation_player.speed_scale = 1

## Basic projectile attack function
func shoot():
	var p = Projectile.instantiate()
	owner.add_child(p)
	p.transform = $Muzzle.global_transform
	shootCooldown = 50
	

## Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("idle")
