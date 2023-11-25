extends Node

@onready var player: CharacterBody2D = get_node("World/Player")
@onready var lapcount: Label = get_node("GUI/LapCounter")

# Called when the node enters the scene tree for the first time.
func _ready():
	lapcount.start(player.lap_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_lap_finished():
	pass # Replace with function body.
