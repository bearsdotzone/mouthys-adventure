extends Label

@onready
var iPlayerVariables = get_node("/root/PlayerVariables")
# Called when the node enters the scene tree for the first time.
func _ready():
	iPlayerVariables.score_changed.connect(on_score_changed)
	pass # Replace with function body.


func on_score_changed(new_score):
	set_text(str(round(new_score)))

