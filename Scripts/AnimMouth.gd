extends Node2D


var mouthStep = 0
var mouthEnd = 30
var mouthSpeed = 250

var mouthTop
var mouthBottom

# Called when the node enters the scene tree for the first time.
func _ready():
	mouthTop = get_child(0)
	mouthBottom = get_child(1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if mouthStep < mouthEnd:
		mouthTop.rotate(deg_to_rad(mouthSpeed * delta))
		mouthBottom.rotate(deg_to_rad(mouthSpeed * -1 * delta))
		mouthStep += mouthSpeed * delta
	else:
		mouthTop.rotate(deg_to_rad(mouthSpeed * -1 * delta))
		mouthBottom.rotate(deg_to_rad(mouthSpeed * delta))
		mouthStep -= mouthSpeed * delta
	
	if mouthStep < 0:
		mouthEnd = 30
	if mouthStep > 30:
		mouthEnd = 0
	
	
	pass
