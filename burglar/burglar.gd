extends Spatial

func _ready():
	$Player.connect("detected",self,"_player_detected")

func _player_detected():
	$Gallery/Alarm.trip_alarm()
