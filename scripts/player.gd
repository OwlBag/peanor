extends Node2D

var mousePos = Vector2(0, 0)

var firing = false
var fireDelay = 10;
var fireCountdown = 0;

var fireOffset = Vector2(30, -20);

var peaScene = preload("res://scenes/pea.tscn")

onready var peaSoundPlayer = $PeaSound 
onready var gunSoundPlayer = $GunSound

onready var mySprite = $PeanorSprite

enum {FIREMODE_NORMAL, FIREMODE_RAPID}

var fireMode = FIREMODE_NORMAL

var spreadRng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	mousePos = get_global_mouse_position()
	spreadRng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fireCountdown <= 0:
		if firing:
			fire(position, mousePos);
			fireCountdown = fireDelay
	else:
		fireCountdown -= 1;

func _unhandled_input(event):
#	print(event.as_text())
	match event.get_class():
		"InputEventMouseMotion":
			mousePos = event.position
			if mousePos.x < position.x:
				mySprite.scale.x = -1
				fireOffset.x = -30
			else:
				mySprite.scale.x = 1
				fireOffset.x = 30
				
		"InputEventMouseButton":
			if event.pressed:
				firing = true
				if event.doubleclick:
					print ("double click")
			else:
				firing = false
			

func fire(positionFrom, positionTowards, speed = 3):
	var pea = peaScene.instance()
	add_child(pea)
	
	if fireMode == FIREMODE_NORMAL:
		peaSoundPlayer.play()
	elif fireMode == FIREMODE_RAPID:
		gunSoundPlayer.play()
	
	var spread = 0
	
	var fireVector = (positionTowards - (positionFrom + fireOffset)).normalized();
	fireVector += Vector2(spreadRng.randf_range(-spread, spread), spreadRng.randf_range(-spread, spread))
	fireVector = fireVector.normalized();
	
	pea.init(positionFrom + fireOffset);
	pea.setVelocity(speed, fireVector);
