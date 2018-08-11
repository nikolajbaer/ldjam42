extends Spatial

signal detected
const X = 10
var area
var t

func _ready():
	area = $AlarmZone
	t = 0

func _process(delta):
	area.translation.x = sin(t) * X
	t += delta

