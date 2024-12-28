extends Node2D

@export var pigeon_scene = preload("res://scnes/pigeon.tscn") 
@export var winning_scene: PackedScene = preload("res://scnes/winning.tscn")

var debug_rect = ColorRect.new()

var remaining_pigeons: int = 100

func _ready():
	$AudioStreamPlayer.play()
	get_node("PigeonCounter/PigeonCounter").text = str(remaining_pigeons)
	Global.currency += remaining_pigeons
	pass

#Get Mouce Position on Click
func _input(event):
	if event is InputEventMouse and event.is_action_pressed("click"):
		var mouse_position = get_viewport().get_mouse_position()
		#print("Mouse Position: ", mouse_position)
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
		remaining_pigeons -= 1
		Global.currency -= 1
		if remaining_pigeons == 0:
			get_tree().change_scene_to_packed(winning_scene) #Placeholder, will be changed once a losing scene exists
		get_node("PigeonCounter/PigeonCounter").text = str(remaining_pigeons)
