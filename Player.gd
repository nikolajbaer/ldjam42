extends KinematicBody

const SPEED = 10
const JUMP_SPEED = 500
const GRAVITY = 5
var vel

func _ready():
	vel = Vector3(0,0,0)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	if translation.y < -30:
		#Game Over!
		return
	var v = Vector3(0,vel.y - GRAVITY * delta,0)
	if Input.is_action_pressed("forward"):
		v.z -= SPEED
	if Input.is_action_pressed("backward"):
		v.z += SPEED
	if Input.is_action_pressed("left"):
		v.x -= SPEED
	if Input.is_action_pressed("right"):
		v.x += SPEED
	if  Input.is_action_just_pressed("jump"):
		v.y += JUMP_SPEED * delta
	
	vel = move_and_slide(v)

