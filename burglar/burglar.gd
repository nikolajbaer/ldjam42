extends Spatial

var tripped = false
var anim

var treasure = null
var treasurespot = null
var startingspot = null

func _ready():
	anim = $HUD/AnimationPlayer
	$Player.connect("detected",self,"_player_detected")
	$"Gallery/WayOut".connect("completed",self,"_player_completed")
	$Muzak.playing = true
	anim.play("Intro")
	treasure = $"Gallery/Map/Treasure"
	treasurespot = $"Gallery/TreasureSpot"
	startingspot = $"Gallery/StartingSpot"
	

func _player_detected():
	if not tripped:
		$Gallery/Alarm.trip_alarm()
		$AlarmSound.playing = true
		tripped = true
		anim.stop(true)
		anim.seek(0, true)
		anim.play("Busted")
		get_tree().paused = true
		
func restart_level():
	# end the scene and start it over.
	var current_scene = get_tree().get_root().get_child(0)
	current_scene.queue_free()
	var s = ResourceLoader.load("res://burglar/burglar.tscn")
	get_tree().get_root().add_child(s.instance())
	get_tree().paused = false
	


func _player_completed():
	anim.stop(true)
	anim.seek(0, true)
	anim.queue("YouGotIt")