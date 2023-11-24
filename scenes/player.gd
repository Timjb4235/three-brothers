extends CharacterBody2D

# Direction is clockwise from right
var speed = 100
var acceleration = -1
var angle = 45
var direction_change = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(speed * cos(deg_to_rad(angle)), speed * sin(deg_to_rad(angle)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(velocity * delta)
	speed += acceleration
	angle += direction_change
	velocity = Vector2(speed * cos(deg_to_rad(angle)), speed * sin(deg_to_rad(angle)))
