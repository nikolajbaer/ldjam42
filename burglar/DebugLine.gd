tool
extends ImmediateGeometry

var m = SpatialMaterial.new()

func _ready():
	if Engine.is_editor_hint():
		begin(Mesh.PRIMITIVE_LINES)
		add_vertex(Vector3(1,0,3))
		add_vertex(Vector3(1,0,-3))
		
		add_vertex(Vector3(1,0,3))
		add_vertex(Vector3(-1,0,-3))
		
		add_vertex(Vector3(1,0,-3))
		add_vertex(Vector3(-1,0,3))
		
		add_vertex(Vector3(-1,0,-3))
		add_vertex(Vector3(-1,0,3))
		end()
		m.flags_unshaded = true
		m.flags_use_point_size = true
		m.set_point_size(4.0)
		m.albedo_color = Color(1.0, 0.0, 0.0, 1.0)
		set_material_override(m)

func _process(delta):
	if not Engine.is_editor_hint():
		return

	scale = Vector3(get_parent().sweep_extent,1,1)
