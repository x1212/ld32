
extends AnimatedSprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process( true )
	pass

func _process(delta):
	if (get_parent().happy >= 50.0):
		set_frame(1)
	else:
		set_frame(0)
