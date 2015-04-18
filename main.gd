
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	set_process(true)
	pass


func _process(delta):
	var npcs = get_node("Node2D")
	get_node("no_scroll/people").set_text(str(npcs.people))
	get_node("no_scroll/unhappy").set_text(str(npcs.unhappy_people))
	get_node("no_scroll/happy").set_text(str(npcs.happy_people))

