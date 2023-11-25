extends CharacterBody2D

# Direction is clockwise from right
const initial_speed = 50
var acceleration = Vector2(0, 0)
var rotation_input = 0
var accel_input = 0
var direction_change = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(initial_speed * cos(deg_to_rad(rotation)), initial_speed * sin(deg_to_rad(rotation)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	rotation += rotation_input * delta
	print(transform.x)
	velocity += transform.x * accel_input
	move_and_collide(velocity * delta)
	
# Receives input from the player via arrow keys
func get_input():
	rotation_input = Input.get_axis("left", "right")
	accel_input = 5 * Input.get_axis("down", "up")
	print(accel_input)
	print(rotation_input)

