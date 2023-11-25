extends Label

var gametime = 0.0
var time = 0.0 

func _ready():
	pass

func _physics_process(delta):
	gametime += delta
	var minutes = gametime / 60
	var seconds = fmod(gametime,60)
	var milliseconds = fmod(gametime,1)*100

	time = str("%02d:%02d:%02d") % [minutes,seconds,milliseconds]
	text =  time
