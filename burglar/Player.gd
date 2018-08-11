extends KinematicBody

const SPEED = 3
const SPRINT = 3
const GRAVITY = 5
const MOUSE_SENSITIVITY = 0.1
var vel
var camera
var detect_radius
var pivot

func _ready():
	vel = Vector3(0,0,0)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera = $Camera
	detect_radius = 1.5
	pivot = $Pivot
	
func _physics_process(delta):
		
	var spd = 0
	if Input.is_action_pressed("forward"):
		spd = 1
	if Input.is_action_pressed("backward"):
		spd = -1
		
	if Input.is_action_pressed("sprint"):
		spd *= SPRINT
		detect_radius = 5
	else:
		detect_radius = 1.5
	
	var dir = Vector3(0,0,spd)
	dir = dir.rotated(Vector3(0,1,0),pivot.rotation.y).normalized() * abs(spd) * SPEED
	
	vel = move_and_slide(dir)

func _input(event):
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        pivot.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		
