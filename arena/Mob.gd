extends KinematicBody

signal death
const SNIFF_RANGE = 5
var target = null
var health

func _ready():
	health = 3
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func bullet_hit(damage,v):
	health -= damage
	if health < 0:
		emit_signal("death")
		# Notify of death?
		queue_free()

func _physics_process(delta):
	if target == null:
		target = get_tree().current_scene.get_node("Player")
	
	rotation.y += deg2rad(1)
		
	var v = Vector3(0,0,0)
	move_and_slide(v)