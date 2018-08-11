extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var light
var triggered
var t

func _ready():
	triggered = false
	light = $Alarm
	t = 0

func trip_alarm():
	triggered = true

func _process(delta):
	t += delta
	if triggered:
		light.light_energy = abs(sin(t*3)) * 2
