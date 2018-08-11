extends Spatial

signal detected
const X = 10
var area
var t

func _ready():
	area = $Area
	t = 0

func _process(delta):
	area.translation.x = sin(t) * X
	t += delta
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
