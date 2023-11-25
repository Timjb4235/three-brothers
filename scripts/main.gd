extends Node
signal game_ended

@onready var player: CharacterBody2D = get_node("World/Player")
@onready var lapcount: Label = get_node("GUI/LapCounter")
@onready var lap_timer: Label = get_node("GUI/LapTimer")
@onready var gui: Node = get_node("GUI")

func _ready():
	lapcount.start(player.lap_finished)
	gui.set_game_ended(game_ended)
	

func _process(delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		var current_mode = DisplayServer.window_get_mode()
		if current_mode == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)

func _on_player_lap_finished():
	if player.max_lap == Config.GAME_LAPS:
		game_ended.emit()
		
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
		
func start(lap_timer, game_ended):
		game_ended.connect(_on_game_ended)
		
func _on_game_ended():
		save_score("New Time", lap_timer.text)
