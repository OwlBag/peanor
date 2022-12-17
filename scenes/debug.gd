extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var peanor

# Called when the node enters the scene tree for the first time.
func _ready():
	peanor = get_tree().get_root().find_node("Peanor", true, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_normalbtn_pressed():
	peanor.setFireMode(0)

func _on_rapidbtn_pressed():
	peanor.setFireMode(1)

func _on_resetbtn_pressed():
	peanor.global_position = Vector2(500, 400)
	peanor.velocity.y = 100
	peanor.move_and_slide(peanor.velocity)
