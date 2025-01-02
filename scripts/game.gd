extends Node2D


const debug: bool = false;

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
		var collision_shape = get_node("Player/View/CollisionShape2D")
		#
		event = make_input_local(event)
		if is_point_inside_circle(event.position, collision_shape):
			if debug: print("Click inside the CollisionShape2D!")
		else:
			if debug: print("Click outside the CollisionShape2D!")
		
		#if get_global_mouse_position().distance_to(collision_shape) > 1: 
			#print("Mouse Position: ", mouse_position)
			debug_rect.set_size(Vector2(20, 20))
			debug_rect.color = Color(1, 0, 0)  # Red color
			#debug_rect.position = position
		
			## get viewport position
			######################################
			var container = get_viewport().get_parent()
			if container != null:
				event = container.make_input_local(event)
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

func is_point_inside_circle(global_point: Vector2, collision_shape: CollisionShape2D) -> bool:
	var circle_shape = collision_shape.shape as CircleShape2D
	if not circle_shape:
		return false  # Ensure it's actually a CircleShape2D
	
	# Transform the global point into the local space of the CollisionShape2D
	var local_point = collision_shape.global_transform.affine_inverse().origin + collision_shape.global_transform.affine_inverse().basis_xform(global_point)
	
	# Check if the point is inside the circle
	if debug: print("Local Point: ", local_point)
	if debug: print("Circle Radius: ", circle_shape.radius)
	return local_point.length() <= circle_shape.radius
