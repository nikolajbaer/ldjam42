extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var p = null;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	p = get_parent();

func _process(delta):
	if p.tripped: 
		if Input.is_action_just_pressed('restart'):
			p.restart_level()

#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
