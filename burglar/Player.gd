extends KinematicBody

signal detected
const SPEED = 4
const SPRINT = 4
const GRAVITY = 5
const MOUSE_SENSITIVITY = 0.1
var vel
var camera
var detect
var pivot
var grabzone
var grabbed_thing
var walking
var idle
var running
var caught = false
var t = 0

func _ready():
	vel = Vector3(0,0,0)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera = $Camera
	detect = $Pivot/DetectZone
	pivot = $Pivot
	grabzone = find_node("GrabZone")
	grabbed_thing = null
	idle = true
	walking = false
	running = false

func busted():
	# HANDS UP SUCKA!
	caught = true
	$"Pivot/Model/Left Arm".hide()
	$"Pivot/Model/Left Arm Long".show()
	$"Pivot/Model/Right Arm".hide()
	$"Pivot/Model/Right Arm Long".show()
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	t += delta
	if caught:
		#pivot.rotation.y = deg2rad(sin(t) * 90)
		return
	
	var old_state = "idle" if idle else "walking" if walking else "running" if running else "idk"

	var spd = 0
	if Input.is_action_pressed("forward"):
		spd = 1
	if Input.is_action_pressed("backward"):
		spd = -1
		
	if Input.is_action_pressed("sprint"):
		spd *= SPRINT
		detect.scale = Vector3(2,1,2)
	else:
		detect.scale = Vector3(1,1,1)
	
	if spd > 0:
		walking = true
		idle = false
		running = false
	if spd == 0:
		idle = true
		walking = false
		running = false	
	if spd > 1:
		running = true
		walking = false
		idle = false
	
	if walking && (old_state != "walking"):
		$AnimationPlayer.play("Walk")

	if idle && (old_state != "idle"):
		$AnimationPlayer.play("Idle")

	if running && (old_state != "running"):
		$AnimationPlayer.play("Run")

	
	if Input.is_action_just_pressed("grab") and grabbed_thing == null:
		# check collisions for treasure
		# if treasure, put up arms
		# if treasure, attach treasure to his...head 
		var maybe_treasures = grabzone.get_overlapping_areas()
		for t in maybe_treasures:
			if t.get_parent().name == "Treasure":
				grabbed_thing = t.get_parent()
				var p = grabbed_thing.get_parent()
				p.remove_child(grabbed_thing)
				pivot.add_child(grabbed_thing)
				grabbed_thing.translation  = Vector3(0,6,0)
				grabbed_thing.rotation.y += deg2rad(90)

	if grabbed_thing:
		$"Pivot/Model/Left Arm".hide()
		$"Pivot/Model/Left Arm Long".show()
		$"Pivot/Model/Right Arm".hide()
		$"Pivot/Model/Right Arm Long".show()
		#var nv = Vector3(0,6,0)
		#grabbed_thing.set_parent(self)
		#grabbed_thing.rotation = $Pivot.rotation
	
	if !grabbed_thing:
		pass

	var dir = Vector3(0,0,spd)
	dir = dir.rotated(Vector3(0,1,0),pivot.rotation.y).normalized() * abs(spd) * SPEED
	
	vel = move_and_slide(dir)

func _input(event):
	if caught: return
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		pivot.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))



func _on_DetectZone_area_entered(area):
	if area.name == "AlarmZone":
		emit_signal("detected")
