extends Node2D


const bullet = preload("res://scnes/bullet.tscn")
#var rotatSpeed = 10

@onready var barrel: Marker2D = $GunBarrel

#Gun Movement to Cursor - manual control
func _process(delta: float) -> void:
	#aimAuto()
	pass
	

func shoot():
	## old implementation
	#var bullet = bulletType.instantiate()
	#get_parent().add_child(bullet)
	#bullet.position = $Gun.global_position
	#bullet.bullet_velocity = get_global_mouse_position()-bullet.position
	
	var bullet_instance = bullet.instantiate()
	bullet_instance.global_position = barrel.global_position
	bullet_instance.bullet_velocity = get_global_mouse_position()-bullet_instance.position
	get_tree().root.add_child(bullet_instance)
	print("shot...")
	
func aimMouse() -> void:
		# rotate gun
	look_at(get_global_mouse_position())
	#clamp rotation
	rotation_degrees = wrap(rotation_degrees,0,360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = - 1
	else:
		scale.y = 1 
	
	if Input.is_action_just_pressed("space"):
		shoot()
		
func shotEnemy(target:Node2D):
		#clamp rotation
	rotation_degrees = wrap(rotation_degrees,0,360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = - 1
	else:
		scale.y = 1 
		
	var bullet_instance = bullet.instantiate()
	bullet_instance.global_position = barrel.global_position
	bullet_instance.bullet_velocity = target.global_position-bullet_instance.position
	get_tree().root.add_child(bullet_instance)
	print("shot...")
