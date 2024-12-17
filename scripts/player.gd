extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

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
	

func _on_view_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	print("Area Entered: " + area.get_parent().name)
	#$Gun.aimAuto(area.get_parent())
	$Gun.aimAuto(area.get_parent())
	#$Gun.shoot()
