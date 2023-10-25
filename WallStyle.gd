extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite = get_child(0)
	sprite.flip_h = round(randf())
	sprite.flip_v = round(randf())
	pass # Replace with function body.

