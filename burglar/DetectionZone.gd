extends Spatial

export (float) var sweep_extent = 10.0
export (float) var sweep_speed = 1.0
signal detected
var area
var t

func _ready():
	area = $AlarmZone
	t = 0

func _process(delta):
	area.translation.x = sin(t/sweep_speed) * sweep_extent
	t += delta
