extends Node2D

var wall = preload("res://Scenes/ObjectWall.tscn")
var wallsH = preload("res://Scenes/WallsH.tscn")
var wallsV = preload("res://Scenes/WallsV.tscn")
var paste = preload("res://Scenes/ItemToothpaste.tscn")
var gun = preload("res://Scenes/ItemGun.tscn")
var dog = preload("res://Scenes/EnemyDog.tscn")
var peanut = preload("res://Scenes/EnemyPeanut.tscn")
var wallsT = preload("res://Scenes/WallsT.tscn")

var wallsChoices = [preload("res://Scenes/WallsT.tscn"),preload("res://Scenes/WallsH.tscn"), preload("res://Scenes/WallsV.tscn")]
var viewport

var rng: RandomNumberGenerator

var mapx = 15
var mapy = 14
var mapsize = mapx * mapy
var mapdata = []

@onready
var iPlayerVariables = get_node("/root/PlayerVariables")

# Called when the node enters the scene tree for the first time.
func _ready():
	mapdata.resize(mapsize)
	mapdata.fill(0)
	viewport = get_viewport_rect()
	rng = RandomNumberGenerator.new()
	rng.seed = level+20
	
	generate_world(false)
	iPlayerVariables.level_changed.connect(on_next_level)
	pass # Replace with function body.

var level = 1


func on_next_level(next_level):
	level = next_level
	rng.seed = level+20
	mapdata.fill(0)
	generate_world(true)
	
func generate_world(delete_existing):
	if delete_existing:
		for i in get_children():
			i.queue_free()
#	print_debug("WORLDGEN: cleared world")
	create_walls()
#	print_debug("WORLDGEN: created walls")
	create_paste()
#	print_debug("WORLDGEN: created paste")
	create_gun()
#	print_debug("WORLDGEN: created gun")
	create_enemies()
#	print_debug("WORLDGEN: created enemies")
#	print_mapdata()

func print_mapdata():
	for i in range(0, mapy):
		print(mapdata.slice(i*mapx, i*mapx+mapx))
	
func position_to_index(x, y):
	x = (x-16) / 16
	y = (y-16) / 16
	return y * mapx + x

func index_to_position(index):
	var returned_position = Vector2(16, 16)
	returned_position.x += (index % mapx) * 16
	returned_position.y += (floor(index / mapx)) * 16
	return returned_position

func create_enemies():
	if rng.randf() < 0.25 + level / 100:
		var temp = dog.instantiate();
		var tempIndex = rng.randi_range(0, mapsize-1)
		while mapdata[tempIndex] > 0:
			tempIndex = rng.randi_range(0, mapsize-1)
		mapdata[tempIndex] = 1
		temp.position = index_to_position(tempIndex)
		add_child(temp)
	if rng.randf() < 0.1 + level / 100:
		add_child(peanut.instantiate())
	pass

func create_gun():
	for i in range(min(round(level/1.2),8)):
		var temp = gun.instantiate();
		var tempIndex = rng.randi_range(0, mapsize-1)
		while mapdata[tempIndex] > 0:
			tempIndex = rng.randi_range(0, mapsize-1)
		mapdata[tempIndex] = 1
		temp.position = index_to_position(tempIndex)
		add_child(temp)

func create_paste():
	for i in range(10):
		var temp = paste.instantiate();
		var tempIndex = rng.randi_range(0, mapsize-1)
		while mapdata[tempIndex] > 0:
			tempIndex = rng.randi_range(0, mapsize-1)
		mapdata[tempIndex] = 1
		temp.position = index_to_position(tempIndex)
		add_child(temp)

func create_walls():
	
	if rng.randf() < 0.50 + level / 100:
		var nodes = wallsChoices[rng.randi_range(0,wallsChoices.size()-1)].instantiate()
		for i in nodes.get_children():
			mapdata[position_to_index(i.position.x, i.position.y)] = 1
		add_child(nodes)
	
	for i in range(0, 260, 16):
		var temp = wall.instantiate()
		temp.position = Vector2(i, 0)
		add_child(temp)
		temp = wall.instantiate()
		temp.position = Vector2(i, viewport.size.y)
		add_child(temp)
	for i in range(0, viewport.size.y, 16):
		var temp = wall.instantiate()
		temp.position = Vector2(0, i)
		add_child(temp)
		temp = wall.instantiate()
		temp.position = Vector2(260, i)
		add_child(temp)
	pass
