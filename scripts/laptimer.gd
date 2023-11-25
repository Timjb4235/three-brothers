extends Label
var gametime = 0.0
var minutes = 0.0
var seconds = 0.0
var milliseconds = 0.0
var time = 0.0 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gametime += delta
	minutes = gametime / 60
	seconds = fmod(gametime,60)
	milliseconds = fmod(gametime,1)*100
	time = str("%02d,%02d,%02d") % [minutes,seconds,milliseconds]
	text =  time
	

