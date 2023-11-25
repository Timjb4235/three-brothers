extends CharacterBody2D

const INITIAL_SPEED = 0
const FRICTION = 19
const ACCEL_STRENGTH = 20
const ROTATION_STRENGTH = 5
const MAX_SPEED = 600
var acceleration = Vector2.ZERO
var rotation_input = 0
var accel_input = 0
var _racetrack: Node2D
var lap_progress:float 
var previous_progress:float 
var lap_count = 0
var max_lap = 0
var bounce_timer = 0
signal lap_finished

# collision_layer and collision_mask defaults are 1

@onready var accel_particles: GPUParticles2D = get_node("AccelerationParticles")
@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")

func start(racetrack, game_restarted):
	_racetrack = racetrack
	game_restarted.connect(_on_game_restarted)
	_on_game_restarted()

func _process(_delta):
	accel_particles.emitting = accel_input > 0
	lap_progress = _racetrack.get_lap_progress(position)
	if lap_progress - previous_progress > 0.9:
		lap_count -= 1
	if previous_progress - lap_progress > 0.9:
		lap_count += 1
	previous_progress = lap_progress
	if lap_count > max_lap and max_lap != Config.GAME_LAPS:
		max_lap = lap_count
		lap_finished.emit()
		
func _physics_process(delta):
	_get_input()
	rotation += ROTATION_STRENGTH * rotation_input * delta

	if velocity.length() > FRICTION * delta:
		velocity = velocity - FRICTION * delta * velocity.normalized()
	velocity += transform.x * accel_input
	if velocity.length() > MAX_SPEED:
		velocity = (velocity / velocity.length()) * MAX_SPEED

	var collision_info = move_and_collide(velocity * delta)

	if collision_info:
		var overlap_depth = collision_info.get_depth()
		var collision_normal = collision_info.get_normal()
		if bounce_timer == 0:
			velocity = velocity.bounce(collision_normal)
			collision_shape.set_disabled(true)
			
			# Try to ensure we're not gonna collide with the wall again straight away
			position += collision_normal * overlap_depth * 1.1
			bounce_timer = 2
			
	# Temporarily disable collisions after a recent bounce
	if bounce_timer > 0:
		bounce_timer -= 1
	else:
		collision_shape.set_disabled(false)

# Receives input from the player
func _get_input():
	rotation_input = Input.get_axis("left", "right")
	accel_input = ACCEL_STRENGTH * Input.get_axis("down", "up")

func _on_game_restarted():
	position = _racetrack.get_start_position()
	rotation = 0.0
	velocity = Vector2(INITIAL_SPEED * cos(deg_to_rad(rotation)), INITIAL_SPEED * sin(deg_to_rad(rotation)))
