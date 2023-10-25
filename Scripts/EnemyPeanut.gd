extends Area2D

var dogspeed = 3
@onready
var iPlayerVariables = get_node("/root/PlayerVariables")

var progress = 100

func _ready():
	get_node("AudioStreamPlayer").finished.connect(_on_sound_effect_finished)
	body_entered.connect(_on_body_entered)
	dogspeed += round(iPlayerVariables.level/3)
	pass

func _physics_process(delta):
	progress += delta
	position = Vector2(100 * sin(progress) + 8*16, 100 * cos(progress) + 7*16)
#	move_and_collide((PCNode.position - position).normalized() * dogspeed * delta)

func _on_body_entered(body):
	if body == get_tree().get_first_node_in_group("PlayerCharacter"):
#		iPlayerVariables.hurt()
		visible = false
		set_deferred("contact_monitor", false)
#		get_node("AudioStreamPlayer").volume_db = linear_to_db(iPlayerVariables.volume)
		get_node("AudioStreamPlayer").play()
		get_tree().call_group("PlayerCharacter", "crunch")
	pass # Replace with function body.

func _on_sound_effect_finished():
	queue_free()
	pass
