
extends "base_char.gd"
const character = preload("res://base_char.gd")

# member variables here, example:
# var a=2
# var b="textvar"
var target

func _ready():
	# Initialization here
	set_process(true)
	set_fixed_process(true)
	pass

func _process(delta):
	if ( target != null   and   target extends character   and   target.get_instance_ID() != get_instance_ID()):
		if (target.happy != UNHAPPY and mood == UNHAPPY):
			var pos = target.get_pos()
			var dir = pos
			dir.x = clamp(pos.x - get_pos().x,-MAX_VEL,MAX_VEL)
			dir.y = clamp(pos.y - get_pos().y,-MAX_VEL*2,0.0)
			walk( dir*Vector2(1.0,2.0) )
			release_mood()
		elif ( target.mood != HAPPY and mood == HAPPY):
			var pos = target.get_pos()
			var dir = pos
			dir.x = clamp(pos.x - get_pos().x,-MAX_VEL,MAX_VEL)
			dir.y = clamp(pos.y - get_pos().y,-MAX_VEL*2,0.0)
			walk( dir*Vector2(1.0,2.0) )
			release_mood()
		else:
			target = null
	#._process(delta)


func _on_vision_body_enter( body ):
	if (body extends character and body.get_instance_ID() != get_instance_ID()):
		target = body

