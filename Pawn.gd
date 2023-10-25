extends RigidBody2D


var moveSpeed = 3
var maxSpeed = 10
var rotationSpeed = 10000

@onready
var iPlayerVariables = get_node("/root/PlayerVariables")

# Called when the node enters the scene tree for the first time.
func _ready():
#	body_entered.connect(_on_body_entered)
#	body_shape_entered.connect(_on_body_shape_entered)
	pass # Replace with function body.

func _integrate_forces(state):
	var moveDirection = get_viewport().get_mouse_position() - position
	var closenessModifier = 1
	if moveDirection.length() < 50:
		closenessModifier = 0.5
	if moveDirection.length() < 10:
		closenessModifier = 0
#	print(moveDirection.length()) 
#	state.linear_velocity = Vector2.ZERO
	state.apply_force(moveDirection * moveSpeed * closenessModifier)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var moveDirection = get_viewport().get_mouse_position() - position
	
	rotation = snapped(moveDirection.angle(), (PI/4)) - PI/4
	
	pass

func crunch():
	find_child("CrunchParticles").emitting = true

#func _on_body_shape_entered(x, body, y, z):
#
#	pass

#func _on_body_entered(body):
#	find_child("CrunchParticles").emitting = true
#	if body.get_collision_layer() & 2:
#		iPlayerVariables.add_score(1)
#		body.queue_free()
	pass # Replace with function body.
