extends Node

@onready var player: CharacterBody2D = get_node("World/Player")
@onready var lapcount: Label = get_node("GUI/LapCounter")

func _ready():
	lapcount.start(player.lap_finished)

func _process(delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		var current_mode = DisplayServer.window_get_mode()
		if current_mode == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)

func _on_player_lap_finished():
	pass # Replace with function body.
