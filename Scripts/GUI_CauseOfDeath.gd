extends Label

@onready
var iPlayerVariables = get_node("/root/PlayerVariables")
# Called when the node enters the scene tree for the first time.
func _ready():
	iPlayerVariables.gamestate_changed.connect(_on_gamestate_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_gamestate_changed(_gamestate_value):
	if iPlayerVariables.lives < 0:
		set_text("You ran out of lives")
	elif iPlayerVariables.timer <= 0:
		set_text("You ran out of time")
	pass
