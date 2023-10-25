extends Label

@onready
var iPlayerVariables = get_node("/root/PlayerVariables")
# Called when the node enters the scene tree for the first time.
func _ready():
	iPlayerVariables.lives_changed.connect(on_lives_changed)
	pass # Replace with function body.


func on_lives_changed(new_score):
	set_text(str(max(0,new_score)))

