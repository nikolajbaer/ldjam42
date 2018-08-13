tool
extends Node

var p
var display

func _run():
	p = get_parent()
	display = MeshInstance.new()
	display.name = "SweepDisplay"
	display.mesh = CubeMesh.new()
	display.scale.x = p.sweep_extent
	display.scale.y = 0.25
	display.scale.z = 0.25
	get_scene().add_child(display)

