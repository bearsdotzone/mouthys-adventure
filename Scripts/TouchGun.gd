extends Area2D


@onready
var iPlayerVariables = get_node("/root/PlayerVariables")

func _ready():
	get_node("AudioStreamPlayer").finished.connect(_on_sound_effect_finished)
	pass

func _on_body_entered(body):
	if body.get_collision_layer() & 4:
		set_deferred("monitoring", false)
		iPlayerVariables.hurt()
		visible = false
#		get_node("AudioStreamPlayer").volume_db = linear_to_db(iPlayerVariables.volume)
		get_node("AudioStreamPlayer").play()
		get_tree().call_group("PlayerCharacter", "crunch")
		
	pass # Replace with function body.

func _on_sound_effect_finished():
	queue_free()
	pass
