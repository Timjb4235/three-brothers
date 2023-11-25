extends Node

@onready var gameend: Node = get_node("GameEnd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_game_ended(game_ended):
	game_ended.connect(_on_game_ended)

func _on_game_ended():
	gameend.show()
	


