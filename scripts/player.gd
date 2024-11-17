extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var bulletType = preload("res://scnes/bullet.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		shoot()
		$Rotation.look_at(get_global_mouse_position())


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal := Input.get_axis("left", "right")
	var vertical := Input.get_axis("up", "down")
	
	if horizontal:
		velocity.x = horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if vertical:
		velocity.y = vertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	
func shoot():
	var bullet = bulletType.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Rotation/Marker2D.global_position
	bullet.bullet_velocity = get_global_mouse_position()-bullet.position
	print("shot...")
	
	
		
