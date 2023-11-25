extends Node

@onready var player: CharacterBody2D = get_node("Player")
@onready var racetrack: Node = get_node("Racetrack")



# Called when the node enters the scene tree for the first time.
func _ready():
	player.start(racetrack)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

"""
func save_score(pilot, time):
	# File access needs to be read-write to add to the end, but needs to be write only to create!
	var f = FileAccess.open("user://highscores.save", FileAccess.READ_WRITE)
	if f and f.is_open():
		f.seek_end()
		f.store_line("{0}, {1}".format([pilot, time], "{_}"))
		f.close()
	
func load_scores():
	var f = FileAccess.open("user://highscores.save", FileAccess.READ)
	if f and f.is_open():
		while not f.eof_reached():
			var line = f.get_line()
			print(line)
		f.close()
"""
