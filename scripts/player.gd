extends KinematicBody2D

var mousePos = Vector2(0, 0)

var firing = false
var fireDelay = 0;
var fireCountdown = 0;

var fireOffset = Vector2(30, -20);

var peaScene = preload("res://scenes/pea.tscn")

onready var peaSoundPlayer = $PeaSound 
onready var gunSoundPlayer = $GunSound

onready var mySprite = $PeanorSprite

enum {FIREMODE_NORMAL, FIREMODE_RAPID}

var fireMode = FIREMODE_NORMAL
var spread = 0
var fireSpeed = 750;

var spreadRng = RandomNumberGenerator.new()
var speed = 500
var velocity = Vector2.ZERO
var falling = true

# Called when the node enters the scene tree for the first time.
func _ready():
	adjustMousePos()
	spreadRng.randomize()
	setFireMode(FIREMODE_NORMAL)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	adjustMousePos()
	if fireCountdown <= 0:
		if firing:
			fire(position, mousePos, fireSpeed);
			fireCountdown = fireDelay
	else:
		fireCountdown -= 1;
		
	if Input.is_action_pressed("player_right"):
		velocity.x = speed
	elif Input.is_action_pressed("player_left"):
		velocity.x = -speed
	else:
		velocity.x = 0
	

func _physics_process(delta):
	if !is_on_wall():
		velocity.y += 10
	else:
		velocity.y = 0
	
	if velocity.y != 0:
		move_and_slide_with_snap(Vector2(0, velocity.y), Vector2(0, 1))
	
	if velocity.x != 0:
		move_and_slide_with_snap(Vector2(velocity.x, 0), Vector2(speed, 0))

func _unhandled_input(event):
#	print(event.as_text())
	match event.get_class():
		"InputEventMouseMotion":
			mousePos = event.position - get_viewport_rect().size/2 + position
				
		"InputEventMouseButton":
			if event.button_index == BUTTON_LEFT:
				if event.pressed:
					firing = true
					if event.doubleclick:
						print ("double click")
				else:
					firing = false

func adjustMousePos():
	mousePos = get_local_mouse_position()*4 + global_position
	
	if mousePos.x < global_position.x:
		mySprite.scale.x = -1
		fireOffset.x = -30
	else:
		mySprite.scale.x = 1
		fireOffset.x = 30

func fire(positionFrom, positionTowards, speed = 1000):
	var pea = peaScene.instance()
	get_parent().add_child(pea)
	
	if fireMode == FIREMODE_NORMAL:
		peaSoundPlayer.play()
	elif fireMode == FIREMODE_RAPID:
		gunSoundPlayer.play()
	
	var fireVector = (positionTowards - (positionFrom + fireOffset)).normalized();
	fireVector += Vector2(spreadRng.randf_range(-spread, spread), spreadRng.randf_range(-spread, spread))
	fireVector = fireVector.normalized();
	
	pea.init(positionFrom + fireOffset);
	pea.setVelocity((speed * fireVector) + velocity);
	
func setFireMode(mode):
	fireMode = mode;
	if fireMode == FIREMODE_NORMAL:
		fireDelay = 10;
		spread = 0;
		fireSpeed = 750;
	elif fireMode == FIREMODE_RAPID:
		fireDelay = 3;
		spread = 0.2;
		fireSpeed = 1000;
