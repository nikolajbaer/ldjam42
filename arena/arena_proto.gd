extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var label
var arena
var n = 3

func _ready():
	label = $HUD/Debug
	arena = $arena
	arena.initialize(n)
	arena.connect("completed",self,"_arena_complete")

func _process(delta):
	if arena != null:
		label.text = "Mobs: %0.0f" % arena.n_mobs
		
func _arena_complete():
	arena.translation.y = 100
	n += 1
	arena.initialize(n)
	arena.translation.y = 0
	# Drop into place

