extends Node

signal game_ended
signal game_restarted

@onready var player: CharacterBody2D = get_node("World/Player")
@onready var racetrack: Node = get_node("World/Racetrack")
@onready var lapcount: Label = get_node("GUI/LapCounter")
@onready var lap_timer: Label = get_node("GUI/LapTimer")
@onready var gui: Node = get_node("GUI")

func _ready():
	lapcount.start(player.lap_finished, game_restarted)
	lap_timer.start(game_restarted)
	gui.set_game_ended(game_ended)
	game_ended.connect(_on_game_ended)
	player.start(racetrack, game_restarted)

func _process(_delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		var current_mode = DisplayServer.window_get_mode()
		if current_mode == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	if Input.is_action_just_pressed("restart"):
		game_restarted.emit()

func _on_player_lap_finished():
	if player.max_lap == Config.GAME_LAPS:
		game_ended.emit()
		
func save_score(pilot, time):
	if not FileAccess.file_exists("user://highscores.save"):
		var f = FileAccess.open("user://highscores.save", FileAccess.WRITE)
		f.close()
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
				
func _on_game_ended():
		save_score("New Time", lap_timer.text)
