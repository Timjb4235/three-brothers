extends Label
var lap = 0

func _ready():
	pass

func _process(_delta):
	text = str("%d / 10") % [lap]

func start(lap_finished):
	lap_finished.connect(_on_lap_finished)

func _on_lap_finished():
	lap += 1
	
