extends Spatial

var tripped = false

func _ready():
	$Player.connect("detected",self,"_player_detected")
	$Muzak.playing = true

func _player_detected():
	if not tripped:
		$Gallery/Alarm.trip_alarm()
		$AlarmSound.playing = true
		tripped = true