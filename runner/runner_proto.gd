extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var tower

func _ready():
	$StaticBody.queue_free() # Placeholder
	tower = preload("res://runner/Tower.tscn")
	
	for i in range(100):
		for j in range (5):
			var t = tower.instance()
			t.translation.z = i * -10
			t.translation.x = j * 10 - 20
			t.set_time(i*0.7)
			add_child(t)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
