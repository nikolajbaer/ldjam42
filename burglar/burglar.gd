extends Spatial

var tripped = false
var anim

func _ready():
	anim = $HUD/AnimationPlayer
	$Player.connect("detected",self,"_player_detected")
	$"Gallery/WayOut".connect("completed",self,"_player_completed")
	$Muzak.playing = true
	anim.play("Intro")

func _player_detected():
	if not tripped:
		$Gallery/Alarm.trip_alarm()
		$AlarmSound.playing = true
		tripped = true
		anim.stop(true)
		anim.seek(0, true)
		anim.play("Busted")
		# anim.remove_animation("Intro")

func _player_completed():
	anim.stop(true)
	anim.seek(0, true)
	anim.queue("YouGotIt")