extends Area2D

var speed = 800
var direction = 1
# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * speed * direction * delta

func Set_Projectile_Direction(dir):
	direction = dir

func _on_body_entered(body):
	if body.is_in_group("BoxEnemy"):
		body.queue_free()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
