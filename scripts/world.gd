extends Node

@onready var player: CharacterBody2D = get_node("Player")
@onready var racetrack: Node = get_node("Racetrack")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.start(racetrack)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func save_score(name, time):
	var save_scores = FileAccess.open("res://savegame.save", FileAccess.WRITE)
	save_scores.store_line("{0}, {1}".format([name, time], "{_}"))
