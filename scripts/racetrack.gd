extends Node

# Width of the track, in pixels
const TRACK_WIDTH: float = 100

# A reference to the Path2D node that defines the racetrack curve.
@onready var _path: Path2D = get_node("Path2D")

# An array of tessellated curve points (these are more dense where the track curves).
var _tessellated_curve_points: PackedVector2Array

# An array of baked curve points.
# These are a fixed distance apart, based on the curve's bake_interval.
# Each point `p` is a Transform with the following data:
# - p.x: sideways vector
# - p.y: forward vector
# - p.get_origin(): position
# - p.get_rotation: rotation
var _baked_curve_points: Array

# Curve that defines the inner wall of the track.
var _inner_curve := Curve2D.new()

# Curve that defines the outer wall of the track.
var _outer_curve := Curve2D.new()

# Line used to visualise the track
var _track_line := Line2D.new()

func _ready():
	rebuild_track()
	add_child(_track_line)

func _process(delta):
	pass

func rebuild_track():
	# Clear previous data
	_baked_curve_points.clear()
	_inner_curve.clear_points()
	_outer_curve.clear_points()
	_track_line.clear_points()

	# Generate tessellated points
	_tessellated_curve_points = _path.curve.tessellate()

	# Generate baked curve and inner/outer curves
	for offset in range(0, _path.curve.get_baked_length(), _path.curve.bake_interval):
		var point_at_offset := _path.curve.sample_baked_with_rotation(offset)
		_baked_curve_points.append(point_at_offset)

		# Define the inner and outer walls by following the normal in both directions
		var inner_point = point_at_offset.get_origin() - point_at_offset.y * (TRACK_WIDTH / 2)
		var outer_point = point_at_offset.get_origin() + point_at_offset.y * (TRACK_WIDTH / 2)
		_inner_curve.add_point(inner_point)
		_outer_curve.add_point(outer_point)

	# Create central line
	for i in _tessellated_curve_points.size():
		var this_point = _tessellated_curve_points[i];
		_track_line.add_point(this_point)

func get_lap_progress(player_position) -> float:
	var curve_dist = _path.curve.get_closest_offset(player_position)
	return curve_dist / _path.curve.get_baked_length()
