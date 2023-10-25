extends Node

var config = ConfigFile.new()

var score = 0
var hiscore = 4000
var lives = 3
var lastLife = 0
var level = 1

var timer_running = false

var default_timer_value = 30
var timer = default_timer_value

var gameState = 0

var volume = 1
signal level_changed(new_level)
signal score_changed(new_score)
signal lives_changed(new_lives)
signal time_changed(new_time)
signal volume_changed(new_volume)
signal timer_toggled(new_state)
signal gamestate_changed(state)
signal hiscore_changed(new_hiscore)

# Called when the node enters the scene tree for the first time.
func _ready():
	if config.load("user://values.cfg") == OK:
		set_hiscore(config.get_value("scores", "hiscore"))
		set_volume(config.get_value("config", "volume"))
		
	else:
		config.set_value("config", "volume", volume)
		config.set_value("scores", "hiscore", hiscore)
		config.save("user://values.cfg")
	pass # Replace with function body.

func start_game():
	if gameState == 1:
		return
	set_gamestate(1)
	set_score(0)
	set_lives(3)
	lastLife = 0
	level = 1
	set_timer(default_timer_value)
	start_timer()

func game_over():
	if gameState == 2:
		return
	set_gamestate(2)
	stop_timer()
	if score > hiscore:
		set_hiscore(score)

func stop_game():
	if gameState == 0:
		return
	set_gamestate(0)
	

func set_hiscore(hiscore_value):
	hiscore = round(hiscore_value)
	config.set_value("scores", "hiscore", hiscore)
	config.save("user://values.cfg")
	hiscore_changed.emit(hiscore)

func add_score(score_increment):
	score += score_increment
	score_changed.emit(score)

func set_score(score_value):
	score = score_value
	score_changed.emit(score)

func set_gamestate(state_value):
	gameState = state_value
	gamestate_changed.emit(gameState)

func hurt():
	add_lives(-1)

func add_lives(life_increment):
	lives += life_increment
	lives_changed.emit(lives)

	if lives < 0:
		game_over()

func set_lives(life_value):
	lives = life_value
	lives_changed.emit(lives)
	
func decrement_time(amount):
	timer -= amount
	time_changed.emit(timer)
	
	if timer < 0:
		game_over()

func set_timer(timer_value):
	timer = timer_value
	time_changed.emit(timer)

func next_level():
	@warning_ignore("integer_division")
	add_score(timer * 5 * max(1, level / 5))
	level += 1
	level_changed.emit(level)
	set_timer(default_timer_value - min(15, level/2.5))

func set_volume(value):
	volume = value
	volume_changed.emit(volume)
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	config.set_value("config", "volume", volume)
	config.save("user://values.cfg")
	pass

func start_timer():
	timer_running = true
	timer_toggled.emit(timer_running)
	
func stop_timer():
	timer_running = false
	timer_toggled.emit(timer_running)

func _process(delta):
	if timer_running:
		decrement_time(1.5 * delta)
		if score >= lastLife + 10000:
			add_lives(1)
			lastLife = score
			next_level()
		
	
