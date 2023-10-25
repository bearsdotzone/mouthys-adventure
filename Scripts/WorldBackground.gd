extends Sprite2D


@onready
var iPlayerVariables = get_node("/root/PlayerVariables")

func _ready():
	iPlayerVariables.level_changed.connect(change_background)

func change_background(new_level):
	if new_level % 5 == 0:
		modulate = Color.from_hsv(randf(), 1, 1, 1)
	pass # Replace with function body.

