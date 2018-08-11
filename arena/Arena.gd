extends Spatial

signal completed
var mob_scene = preload("res://arena/Mob.tscn")
var n_mobs = 3

func initialize(n):
	$Wall.translation = $Wall.start
	$Wall2.translation = $Wall2.start
	$Wall3.translation = $Wall3.start
	$Wall4.translation = $Wall4.start
	
	n_mobs = n
	for i in range(n):
		var m = mob_scene.instance()
		m.name = "Mob_%f"%i
		m.translation.x = 30 - randf() * 60
		m.translation.z = 30 - randf() * 60
		add_child(m)
		m.connect("death",self,"_mob_death")

func _mob_death():
	n_mobs -= 1
	if n_mobs == 0:
		emit_signal("completed")

