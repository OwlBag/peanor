extends Sprite

var mousePos = Vector2(0, 0)

var firing = false
var fireDelay = 5;
var fireCountdown = 0;

var fireOffset = Vector2(30, -20);

var peaScene = preload("res://scenes/pea.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	mousePos = get_global_mouse_position()


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
	
	var fireVector = (positionTowards - positionFrom).normalized();
	
	pea.init(positionFrom + fireOffset);
	pea.setVelocity(speed, fireVector);
