
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

var move_dir = Vector2(0.0,0.0)
var vel = Vector2(0.0,0.0)
var MAX_VEL = 126.0
var GRAV = 256.0
export var happy = 0.0

const HAPPY = 2
const NEUTRAL = 1
const UNHAPPY = 0
var mood = UNHAPPY

var mood_trace = null
const mood_scene = preload("res://mood_traces.scn")

var cooldown = 0.0

func _ready():
	# Initialization here
	if ( happy >= 20.0  and happy < 50.0 ):
		mood = NEUTRAL
	elif ( happy < 20.0 ):
		mood = UNHAPPY
	else:
		mood = HAPPY
	set_fixed_process( true )
	pass

func walk(dir):
	move_dir +=dir
	if (dir.x < 0.0):
		get_node("face").set_flip_h(true)
		get_node("body_sprite").set_flip_h(true)
	elif (dir.x > 0.0):
		get_node("face").set_flip_h(false)
		get_node("body_sprite").set_flip_h(false)


func movement(delta):
	if (abs(move_dir.x) < 1.0):
		vel.x *= 1.0-delta*4
	if (sign(vel.x) == sign(move_dir.x)):
		vel.x += delta*move_dir.x
	else:
		vel.x += delta*move_dir.x*3.0
	if (abs(vel.x) > MAX_VEL):
		vel.x = sign(vel.x)*MAX_VEL
	if (abs(vel.x) > 6.0 and (get_node("body_sprite/AnimationPlayer").get_current_animation() != "run" and get_node("body_sprite/AnimationPlayer").is_active()) ):
		get_node("body_sprite/AnimationPlayer").play("run")
	elif (abs(vel.x) <= 6.0 and (get_node("body_sprite/AnimationPlayer").get_current_animation() != "stand" and get_node("body_sprite/AnimationPlayer").is_active())):
		get_node("body_sprite/AnimationPlayer").play("stand")
	
	#jump
	#if ( get_node("cast").is_colliding() and get_node("cast").get_collision_normal().y < -0.5 and move_dir.y < 0.0 ):
	if ( get_node("cast").is_colliding() and is_colliding() and get_node("cast").get_collision_normal().y < -0.5 and move_dir.y < 0.0 ):
		vel.y = move_dir.y
	#elif ( get_node("cast").is_colliding() and get_node("cast").get_collision_normal().y < -0.5):
	elif ( get_node("cast").is_colliding() and is_colliding() and get_node("cast").get_collision_normal().y < -0.5):
		vel.y = 0.0
	elif ( is_colliding() ):
		vel = get_collision_normal().slide(vel)
	else:
		vel.y += delta*GRAV
	
	
	move( delta*vel )
	move_dir = Vector2(0.0,0.0)
	pass

func change_happy( delta ):
	print ("change happy")
	print (delta)
	print ( happy )
	happy += delta
	if ( happy < 0.0 ):
		happy = 0.0
	elif ( happy > 100.0 ):
		happy = 100.0

func release_mood():
	if (cooldown >= 0.0):
		return
	
	mood_trace = mood_scene.instance()
	if (mood != UNHAPPY):
		mood_trace.happy = true
		get_node("face").set_frame(4)
	else:
		mood_trace.happy = false
		get_node("face").set_frame(0)
	mood_trace.source = get_node(".")
	mood_trace.creator = get_node(".")
	mood_trace.set_pos(.get_pos())
	get_parent().add_child(mood_trace)
	get_node("face").animated = true
	get_node("face").release_animated = 1.0
	
	
	cooldown = 2.0
	


func _fixed_process( delta ):
	cooldown -= delta
	movement(delta)
	# neutral
	if ( happy >= 20.0  and happy < 50.0 ):
		mood = NEUTRAL
	elif ( happy < 20.0 ):
		mood = UNHAPPY
	else:
		mood = HAPPY
	pass

