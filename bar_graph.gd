
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

var time = 0.0

func _ready():
	# Initialization here
	set_process( true )
	pass

func _process(delta):
	time += delta*get_parent().happy/10.0
	var tmp = get_parent().happy/100.0
	clamp(tmp,0.1,0.5)
	var color = Color( ((1.0+sin(time))/4.0 )*tmp+ 0.5, ((1.0+cos(time*1.3))/4.0 )*tmp+ 0.5, ((1.0+sin(time*3.0))/4.0 )*tmp+ 0.5)
	set_modulate( color )
	set_region_rect( Rect2(0,0,get_parent().happy/100*get_texture().get_width(),32) )
	set_region( true )
