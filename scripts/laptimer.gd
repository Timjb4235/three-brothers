extends Label
var gametime = 0.0
var minutes = 0.0
var seconds = 0.0
var milliseconds = 0.0

func _ready():
	pass

func _physics_process(delta):
	gametime += delta
	minutes = gametime / 60
	seconds = fmod(gametime,60)
	milliseconds = fmod(gametime,1)*100
	text = str("%02d:%02d:%02d") % [minutes,seconds,milliseconds] 
