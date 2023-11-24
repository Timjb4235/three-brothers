extends Label
var gametime = 0.0
var minutes = 0.0
var seconds = 0.0
var milliseconds = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gametime += delta
	minutes = floor(gametime / 60)
	seconds = floor(gametime - minutes*60)
	# milliseconds = tba
	text = str(minutes, " ' ", seconds, " '' ") 	
	
