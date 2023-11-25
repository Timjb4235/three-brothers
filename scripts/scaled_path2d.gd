extends Path2D

@export var point_scales: PackedFloat32Array

func _ready():
	for i in curve.point_count:
		if i >= point_scales.size():
			# Default to 1 if no scale is set
			point_scales.append(1.0)

func _process(delta):
	pass

# Given an offset along the path between 0 and 1, calculates the point scale
func calc_point_scale_at_offset(offset: float):
	# Calculate the point scale by interpolating between the points either side of this offset
	var offset_relative_to_num_points = offset * curve.point_count
	var prev_point_index = floor(offset_relative_to_num_points)
	var next_point_index = ceil(offset_relative_to_num_points)
	if next_point_index >= curve.point_count:
		# Wrap around
		next_point_index = 0
	var point_scale_floor = point_scales[prev_point_index]
	var point_scale_ceil = point_scales[next_point_index]
	var progress_to_next_point = offset_relative_to_num_points - prev_point_index;
	return lerp(point_scale_floor, point_scale_ceil, progress_to_next_point)
