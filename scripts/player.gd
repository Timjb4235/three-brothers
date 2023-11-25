extends CharacterBody2D

const INITIAL_SPEED = 50
const FRICTION = 0.98
const ACCEL_STRENGTH = 5
const ROTATION_STRENGTH = 2.5
const MAX_SPEED = 250
# const SPIN_MULTIPLIER = 5
var acceleration = Vector2(0, 0)
var rotation_input = 0
var accel_input = 0
# var spin = 0
var _racetrack: Node2D
var lap_progress:float 
var previous_progress:float 
var lap_count = 0

# collision_layer and collision_mask defaults are 1

@onready var accel_particles: GPUParticles2D = get_node("AccelerationParticles")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("player ready")
	velocity = Vector2(INITIAL_SPEED * cos(deg_to_rad(rotation)), INITIAL_SPEED * sin(deg_to_rad(rotation)))

func start(racetrack):
	_racetrack = racetrack
	position = _racetrack.get_start_position()

@warning_ignore("unused_parameter")
func _process(delta):
	accel_particles.emitting = accel_input > 0
	lap_progress = _racetrack.get_lap_progress(position)
	if lap_progress - previous_progress > 0.9:
		lap_count -= 1
	if previous_progress - lap_progress > 0.9:
		lap_count += 1
	previous_progress = lap_progress
	print("lap = ", lap_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_get_input()
	rotation += ROTATION_STRENGTH * rotation_input * delta
	# rotation += spin * delta
	# if rotation_input != 0 and spin > 0:
	# 	spin *= 0.3 ** delta
	# if spin < 0.1:
	# 	spin = 0
	velocity *= FRICTION ** delta
	velocity += transform.x * accel_input
	if velocity.length() > MAX_SPEED:
		velocity = (velocity / velocity.length()) * MAX_SPEED
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		#var collision_angle = velocity.normalized().dot(collision_info.get_normal())
		#if velocity.normalized().angle() - collision_info.get_normal().angle() > 0:
		#	spin -= abs(1 - collision_angle) * SPIN_MULTIPLIER
		#else:
		#	spin -= abs(1 - collision_angle) * SPIN_MULTIPLIER
		#

	
	


# Receives input from the player via arrow keys
func _get_input():
	rotation_input = Input.get_axis("left", "right")
	accel_input = ACCEL_STRENGTH * Input.get_axis("down", "up")


