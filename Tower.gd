extends StaticBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var falling
var v
const G = 0.05

func _ready():
	falling = false
	v = 0

func set_time(offset):
	$Timer.wait_time = randf() * 10 + offset
	$Timer.start()

func _physics_process(delta):
	if falling:
		translation.y -= v * delta
		v += G
	#if translation.y < 100: queue_free()
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	falling = true
