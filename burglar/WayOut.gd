extends Spatial

signal completed
var complete = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	var maybe_player_detection = $Area.get_overlapping_areas()
	#print("Maybe: %s" % [maybe_player_detection])
	for m in maybe_player_detection:
		# it's the player's detect zone, so 
		# they finished the level!
		if m.name == "DetectZone":
			# what do we do when they finish?
			# set a new scene?
			if not complete:
				emit_signal("completed")
			complete = true
