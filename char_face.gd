
extends AnimatedSprite

# member variables here, example:
# var a=2
# var b="textvar"

var animated = false
var release_animated = 0.0

func _ready():
	set_process( true )

func _process(delta):
	var parent = get_parent()
	release_animated -= delta
	if (release_animated <= 0.0):
		animated = false
		release_animated = 0.0
	if ( not animated ):
		if (parent.happy < 20.0):
			set_frame(1)
		if (parent.happy >= 20.0):
			set_frame(2)
		if (parent.happy >= 50.0):
			set_frame(3)
