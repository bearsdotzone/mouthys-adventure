extends Control

@onready
var iPlayerVariables = get_node("/root/PlayerVariables")
# Called when the node enters the scene tree for the first time.
func _ready():
	_on_gamestate_changed(iPlayerVariables.gameState)
	iPlayerVariables.gamestate_changed.connect(_on_gamestate_changed)

func _on_gamestate_changed(state):
	if state == 0:
		visible = true
	else:
		visible = false
	
func _gui_input(event):
	if event is InputEventMouseButton:
		iPlayerVariables.start_game()
