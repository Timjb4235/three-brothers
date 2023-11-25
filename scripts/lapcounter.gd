extends Label

var lap = 0

func _ready():
	pass

func _process(_delta):
	text = str("%d / %d") % [lap, Config.GAME_LAPS]

func start(lap_finished, game_restarted):
	lap_finished.connect(_on_lap_finished)
	game_restarted.connect(_on_game_restarted)

func _on_lap_finished():
	if lap <= Config.GAME_LAPS:
		lap += 1

func _on_game_restarted():
	lap = 0
