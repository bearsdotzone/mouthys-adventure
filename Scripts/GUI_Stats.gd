extends Label

@onready
var iPlayerVariables = get_node("/root/PlayerVariables")
# Called when the node enters the scene tree for the first time.
func _ready():
	iPlayerVariables.gamestate_changed.connect(_on_gamestate_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_gamestate_changed(_delta):
	var output = ""
	output += "Final Score: " + str(round(iPlayerVariables.score)) + "\n"
	if round(iPlayerVariables.hiscore) == round(iPlayerVariables.score):
		output += "New Hiscore!\n"
	output += "Final Level: " + str(iPlayerVariables.level) + "\n"
	output += "Click to Continue"
	set_text(output)
	pass
