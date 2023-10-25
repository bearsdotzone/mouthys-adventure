extends MarginContainer

var CreditsPane

# Called when the node enters the scene tree for the first time.
func _ready():
	CreditsPane = find_child("CreditsPane")

func _on_button_pressed():
	CreditsPane.visible = !CreditsPane.visible
