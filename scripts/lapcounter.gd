extends Label
var lap = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str("%d / %d") % [lap, Config.GAME_LAPS]

func start(lap_finished):
	lap_finished.connect(_on_lap_finished)

func _on_lap_finished():
	if lap <= Config.GAME_LAPS:
		lap += 1
	
