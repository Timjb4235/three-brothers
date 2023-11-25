extends CharacterBody2D

# Direction is clockwise from right
const initial_speed = 100
var acceleration = Vector2(0, 0)
var angle = 0
var rotation_input
var accel_input
var direction_change = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(initial_speed * cos(deg_to_rad(angle)), initial_speed * sin(deg_to_rad(angle)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	#print(accel_input)
	#print(rotation_input)
	angle += rotation_input
	print(transform.x)
	velocity += transform.x * accel_input
	#print(accel_input)
	#print(velocity)
	move_and_collide(velocity * delta)
	# speed += acceleration
	# angle += direction_change
	# velocity = Vector2(speed * cos(deg_to_rad(angle)), speed * sin(deg_to_rad(angle)))

# Receives input from the player via arrow keys
func get_input():
	# Left negative, right positive
	rotation_input = Input.get_axis("left", "right")
	accel_input = Input.get_axis("down", "up")
	print(accel_input)
	print(rotation_input)
