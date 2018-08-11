extends StaticBody

const CREEP = 1
var start

func _ready():
	start = Vector3(translation)

func _process(delta):
	if abs(translation.x) > 0:
		translation.x -= CREEP * sign(translation.x) * delta
	if abs(translation.z) > 0:
		translation.z -= CREEP * sign(translation.z) * delta

