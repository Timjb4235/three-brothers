extends Node

var _path
var _curve_points

func _ready():
	_path = get_node("Path2D")
	rebuild_track()
	
	# TMP
	for i in _curve_points.size():
		print(_curve_points[i])

func _process(delta):
	pass

func rebuild_track():
	_curve_points = _path.curve.tessellate()
