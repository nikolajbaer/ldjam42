extends Node
var current = null
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var c = $"WorldEnvironment/Camera"
	c.make_current()
	current = get_tree().get_root().get_child(0)
	
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			current.queue_free()
			var s = ResourceLoader.load("res://burglar/burglar.tscn")
			get_tree().get_root().add_child(s.instance())
			