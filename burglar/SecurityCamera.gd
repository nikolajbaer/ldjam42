extends Spatial

export (NodePath) var target = null
var _target = null

func _ready():
	if target != null:
		_target = get_node(target)

func _process(delta):
	if _target != null:
		look_at(_target.area.global_transform.origin,Vector3(0,0,1))
