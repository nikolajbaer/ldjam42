extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var label
var arena
var n = 1
var tween
var timer
var dropping

func _ready():
	label = $HUD/Debug
	arena = $arena
	arena.initialize(n)
	arena.connect("completed",self,"_arena_complete")
	timer = $Timer
	tween = $Tween

func _process(delta):
	if arena != null:
		label.text = "Mobs: %0.0f" % arena.n_mobs
		
func _arena_complete():
	timer.start()

func _on_Timer_timeout():	
	# TODO Warn user with countdown
	drop()


func drop():
	# TODO kill user if not on platform
	tween.interpolate_property(arena, "translation",
                Vector3(0,0,0),Vector3(0,-400,0), 1,
                Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	dropping = true

func _on_Tween_tween_completed(object, key):
	if dropping:
		n += 1
		dropping = false
		arena.initialize(n)
		arena.translation.y = 100
		tween.interpolate_property(arena, "translation",
	                Vector3(0,100,0),Vector3(0,0,0), 1,
	                Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
	else:
		#arena.activate()
		pass
	