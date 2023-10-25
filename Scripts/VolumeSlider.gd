extends HSlider


@onready
var iPlayerVariables = get_node("/root/PlayerVariables")

func _ready():
	set_value(iPlayerVariables.volume)

func _on_value_changed(new_volume):
	iPlayerVariables.set_volume(new_volume)
