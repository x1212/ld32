
extends Node2D
const char = preload( "res://base_char.gd" )

# member variables here, example:
# var a=2
# var b="textvar"
var happy = true
var source = null
var creator = null
var time = 0.0

func _ready():
	# Initialization here
	set_process( true )
	if (happy):
		get_node("happy").show()
	else:
		get_node("unhappy").show()
	pass

func _process(delta):
	time += delta*16
	var tmp = 0.5
	var color = Color( ((1.0+sin(time))/4.0 )*tmp+ 0.5, ((1.0+cos(time*1.3))/4.0 )*tmp+ 0.5, ((1.0+sin(time*3.0))/4.0 )*tmp+ 0.5)
	get_node("happy").set_modulate( color )
	get_node("happy").scale(Vector2(1.0+delta/3.0,1.0+delta/3.0))
	get_node("unhappy").scale(Vector2(1.0+delta/3.0,1.0+delta/3.0))
	if (time > 4.0):
		get_node("happy").set_opacity( get_node("happy").get_opacity() - delta )
	if (get_node("happy").get_opacity() <= 0.0 ):
		if ( creator != null ):
			creator.mood = null
		queue_free()



func _on_Area2D_body_enter( body ):
	if (body extends char):
		if (body == source):
			print ("source happy")
			return
		if (happy == true):
			var was_unhappy = body.happy < 20.0
			var was_neutral = ( body.happy < 50.0 and body.happy >= 20.0 )
			body.change_happy(  5.0 )
			if ( was_unhappy and body.happy >= 20.0 ):
				if (source != null):
					print ("target neutral source happy")
					source.change_happy(10.0)
			elif ( was_neutral and body.happy >= 50.0 ):
				if (source != null):
					print ("target happy source happy")
					source.change_happy(25.0)
		else:
			body.change_happy( -5.0 )
	pass # replace with function body
