extends Node

@onready var player: CharacterBody2D = get_node("Player")
@onready var racetrack: Node = get_node("Racetrack")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.start(racetrack)
	save_score("Joel", "Slow")
	load_scores()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func save_score(name, time):
	var f = FileAccess.open("res://savegame.save", FileAccess.READ_WRITE)
	if f and f.is_open():
		f.seek_end()
		f.store_line("{0}, {1}".format([name, time], "{_}"))
		f.close()
	
func load_scores():
	var f = FileAccess.open("res://savegame.save", FileAccess.READ)
	if f and f.is_open():
		var index = 1
		while not f.eof_reached():
			var line = f.get_line()
			print(line)
			index += 1
		f.close()
