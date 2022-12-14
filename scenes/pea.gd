extends Node2D

var speed = 0;
var direction = Vector2(0, 0);

var lifeTime = 60;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed
	lifeTime -= 1;
	
	if lifeTime <= 0:
		queue_free()

func init(initialPosition):
	global_position = initialPosition

func setVelocity(newSpeed, newDirection):
	speed = newSpeed;
	direction = newDirection;
