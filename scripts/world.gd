extends Node

@onready var player: CharacterBody2D = get_node("Player")
@onready var racetrack: Node = get_node("Racetrack")

# Called when the node enters the scene tree for the first time.
func _ready():
		player.racetrack = racetrack


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
