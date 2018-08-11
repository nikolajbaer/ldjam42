extends KinematicBody

const SPEED = 10
const JUMP_SPEED = 500
const GRAVITY = 5
const MOUSE_SENSITIVITY = 0.1
const RELOAD = 0.5
var vel
var camera
var turret
var muzzle
var reload
var health
var ammo

func _ready():
	vel = Vector3(0,0,0)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera = $Camera
	turret = $Turret
	muzzle = $Turret/Muzzle
	health = 5
	reload = 0
	ammo = load("res://arena/EnergyBall.tscn")
	
func bullet_damage(damage,v):
	health -= damage
	if health <= 0:
		#Game Over!
		pass

func fire():
	var b = ammo.instance()
	b.global_transform = muzzle.global_transform
	get_tree().current_scene.add_child(b)

func _physics_process(delta):
		
	var spd = 0
	if Input.is_action_pressed("forward"):
		spd = 1
	if Input.is_action_pressed("backward"):
		spd = -1
		
	var dir = Vector3(0,0,spd)
	
	if Input.is_action_pressed("left"):
		if spd >= 0: rotation.y += deg2rad(1)
		else: rotation.y -= deg2rad(1)
	if Input.is_action_pressed("right"):
		if spd >= 0: rotation.y -= deg2rad(1)
		else: rotation.y += deg2rad(1)

	if Input.is_action_pressed("fire") and reload <= 0:
		fire()
		reload = RELOAD
	if reload > 0: reload -= delta	

	dir = dir.rotated(Vector3(0,1,0),rotation.y).normalized() * SPEED
	#dir.y -= GRAVITY * delta
	
	vel = move_and_slide(dir)

func _input(event):
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        turret.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		
