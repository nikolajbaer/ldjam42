extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const X = 5
const SPD = 0.2
var flip = true
var a = 0
var detect

func _ready():
	detect = $Detect

func _process(delta):
	if flip:
		if a > deg2rad(-45):
			a -= deg2rad(SPD)
		else:
			flip = false
	else:
		if a < deg2rad(45):
			a += deg2rad(SPD)
		else:
			flip = true
	

	detect.rotation.z = a