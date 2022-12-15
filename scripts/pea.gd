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
	scale = Vector2(0.2, 0.2)
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)

func setVelocity(newSpeed, newDirection):
	speed = newSpeed;
	direction = newDirection;
