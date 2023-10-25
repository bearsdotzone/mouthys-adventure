extends Label

@onready
var iPlayerVariables = get_node("/root/PlayerVariables")

func _ready():
	set_text(str(iPlayerVariables.hiscore))
	iPlayerVariables.hiscore_changed.connect(_on_hiscore_changed)


func _on_hiscore_changed(hiscore_value):
	set_text(str(hiscore_value))
