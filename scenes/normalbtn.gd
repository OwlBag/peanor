extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var btngroup

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_normalbtn_pressed():
	get_tree().root.find_node("Peanor").fireMode