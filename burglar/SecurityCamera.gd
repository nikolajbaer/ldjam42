extends Spatial

export (NodePath) var target = null
var _target

func _ready():
	_target = get_node(target)

func _process():
	if _target:
		look_at(_target.global_transform.origin,Vector3(0,1,0))