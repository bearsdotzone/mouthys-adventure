extends Node2D

@onready
var iPlayerVariables = get_node("/root/PlayerVariables")
var GeneratedGameWorld
var GameWorldGenerator = preload("res://Scenes/World.tscn")
var BackgroundMusic: AudioStreamPlayer

var tracks = ["res://Sounds/track_^.ogg",
	"res://Sounds/track_detroit.mp3",
	"res://Sounds/track_wyver.ogg",
	"res://Sounds/track_grey.mp3"]

# Called when the node enters the scene tree for the first time.
func _ready():
	iPlayerVariables.gamestate_changed.connect(_on_gamestate_changed)
	iPlayerVariables.level_changed.connect(_on_level_changed)
	GeneratedGameWorld = find_child("GeneratedGameWorld")
	BackgroundMusic = find_child("BackgroundMusic")
	pass # Replace with function body.

func _on_gamestate_changed(state):
	if state == 1:
		GeneratedGameWorld.add_child(GameWorldGenerator.instantiate())
	else:
		for i in GeneratedGameWorld.get_children():
			i.queue_free()

func _on_level_changed(_new_level):
	if(_new_level % 5 == 0):
		@warning_ignore("integer_division")
		BackgroundMusic.stream = load(tracks[int(_new_level) % 20 / 5])
		BackgroundMusic.play()
