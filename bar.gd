
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var happy = 50.0

func _ready():
	# Initialization here
	#set_process( true )
	pass

func _process(delta):
	change_happy(delta*4)

func change_happy( delta ):
	happy += delta
	if ( happy < 0.0 ):
		happy = 0.0
	elif ( happy > 100.0 ):
		happy = 100.0