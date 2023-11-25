extends Node

@onready var player: CharacterBody2D = get_node("Player")
@onready var racetrack: Node = get_node("Racetrack")

func _ready():
	player.start(racetrack)
	save_score("Joel", "Slow")
	load_scores()

func _process(_delta):
	pass

func save_score(pilot, time):
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
