
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var current_level = 1
const level0 = preload("res://level1.scn")
const level1 = preload("res://level1.scn")

func _ready():
	# Initialization here
	set_process(true)
	pass

func switch_level( num ):
	var levels = {
		0:level0,
		1:level1,
		2:level1
	}
	if ( levels[num] == null ):
		print("level not found")
		return
	var level = get_node("Node2D")
	remove_and_delete_child( level )
	level = levels[num].instance()
	level.set_name("Node2D")
	add_child(level)
	move_child(level,0)
	current_level = num
	pass

func _process(delta):
	var npcs = get_node("Node2D")
	get_node("no_scroll/people").set_text(str(npcs.people))
	get_node("no_scroll/unhappy").set_text(str(npcs.unhappy_people))
	get_node("no_scroll/happy").set_text(str(npcs.happy_people))
	if (npcs.people == 0):
		return
	if ( npcs.people == npcs.happy_people ):
		get_node("no_scroll/nextLevel").show()
		if ( Input.is_action_pressed("ui_accept") ):
			switch_level( current_level + 1 )
			return
		elif ( Input.is_action_pressed("ui_cancel")):
			switch_level( 0 )
			return
	else:
		get_node("no_scroll/nextLevel").hide()
	if ( npcs.happy_people == 0 and npcs.get_node("character").happy < 20.0):
		get_node("no_scroll/loose").show()
		if ( Input.is_action_pressed("ui_accept") ):
			switch_level( current_level )
			return
		elif ( Input.is_action_pressed("ui_cancel")):
			switch_level( 0 )
			return
	else:
		get_node("no_scroll/loose").hide()

