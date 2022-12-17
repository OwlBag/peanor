extends Node2D

var peaVelocity = Vector2.ZERO

var lifeTime = 60;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += peaVelocity * delta
	lifeTime -= 1;
	
	if lifeTime <= 0:
		queue_free()

func init(initialPosition):
	global_position = initialPosition
	scale = Vector2(0.2, 0.2)
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(4, 4), 0.2)

func setVelocity(velocity):
	peaVelocity = velocity
