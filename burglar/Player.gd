extends KinematicBody

signal detected
const SPEED = 3
const SPRINT = 3
const GRAVITY = 5
const MOUSE_SENSITIVITY = 0.1
var vel
var camera
var detect_radius
var pivot
var grabzone
var grabbed_thing

func _ready():
	vel = Vector3(0,0,0)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera = $Camera
	detect_radius = 1.5
	pivot = $Pivot
	grabzone = find_node("GrabZone")
	grabbed_thing = null

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
	
	if Input.is_action_just_pressed("grab"):
		# check collisions for treasure
		# if treasure, put up arms
		# if treasure, attach treasure to his...head 
		var maybe_treasures = grabzone.get_overlapping_areas()
		for t in maybe_treasures:
			if t.get_parent().name == "Treasure":
				grabbed_thing = t.get_parent()

	if grabbed_thing:
		$"Pivot/Model/Left Arm".hide()
		$"Pivot/Model/Left Arm Long".show()
		$"Pivot/Model/Right Arm".hide()
		$"Pivot/Model/Right Arm Long".show()
		var nv = Vector3(get_translation())
		nv.y += 6
		grabbed_thing.set_translation(nv)
		grabbed_thing.rotation = $Pivot.rotation
	
	if !grabbed_thing:
		pass

	var dir = Vector3(0,0,spd)
	dir = dir.rotated(Vector3(0,1,0),pivot.rotation.y).normalized() * abs(spd) * SPEED
	
	vel = move_and_slide(dir)

func _input(event):
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        pivot.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

func _on_DetectionZone_area_entered(area):
	if area.name == "AlarmZone":
		emit_signal("detected")

