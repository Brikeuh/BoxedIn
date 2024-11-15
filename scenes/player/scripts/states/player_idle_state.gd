extends State
class_name PlayerIdle

@export var animator: AnimationPlayer

func Enter():
	animator.play("idle")
	pass
	
func Update (_delta:float):
	if(Input.get_vector("right", "left", "up", "down").normalized()):
		state_transition.emit(self, "Moving")
	if(Input.is_action_pressed("attack")):
		state_transition.emit(self, "Attack")
