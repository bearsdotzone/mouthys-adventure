extends Label

@onready
var iPlayerVariables = get_node("/root/PlayerVariables")
# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(str(iPlayerVariables.default_timer_value))
	iPlayerVariables.time_changed.connect(on_score_changed)
	pass # Replace with function body.


func on_score_changed(new_score):
	set_text(str(max(0, round(new_score))))

