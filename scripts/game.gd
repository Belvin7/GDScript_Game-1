extends Node2D

var pigeon_scene = preload("res://scnes/pigeon.tscn") 
var debug_rect = ColorRect.new()

func _ready():
	#$AudioStreamPlayer.play()
	pass

#Get Mouce Position on Click
func _input(event):
	if event is InputEventMouse and event.is_action_pressed("click"):
		var mouse_position = get_viewport().get_mouse_position()
		print("Mouse Position: ", mouse_position)
		debug_rect.set_size(Vector2(20, 20))
		debug_rect.color = Color(1, 0, 0)  # Red color
		#debug_rect.position = position
		
		## get viewport position
		######################################
		var container = get_viewport().get_parent()
		if container != null:
			event = container.make_input_local(event)
		
		event = make_input_local(event)
		######################################
		
		## debug test
		######################################
		debug_rect.position = event.position
		#add_child(debug_rect)
		
		## Pigeon Spawner
		#################
		var pigeon = pigeon_scene.instantiate()
		print("Loading Sccene")
		#enemy.position = mouse_position
		pigeon.position = event.position
		add_child(pigeon)
	
		#print_tree()
