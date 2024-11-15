extends State
class_name PlayerAttack

@export var animator : AnimationPlayer
@onready var staple_bullet = preload("res://scenes/player/projectile.tscn")
@onready var sprite_2d = $"../../Sprite2D"
@onready var muzzle = $"../../Muzzle"

func Enter():
	animator.play("shoot")
	
func Update(delta : float):
	if Input.is_action_just_released("attack"):
		state_transition.emit(self, "Attack")
	else:
		await animator.animation_finished
	state_transition.emit(self, "Idle")
	
func Shoot_Projectile():
	var projectile = staple_bullet.instantiate()
	get_parent().add_child(projectile)
	projectile.position = muzzle.global_position
	if sprite_2d.flip_h == true:
		projectile.Set_Projectile_Direction(-1)
