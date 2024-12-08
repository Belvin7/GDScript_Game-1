class_name Pigeon extends CharacterBody2D

@export var _speed: float = 1000.0 # speed of the enemy
@export var _attack_range: float = 200.0 # range of the enemy in which it starts attacking directly
@export var _cohesion_range: float = 800.0 # range of the enemy in which it flocks to other enemies
@export var _seperation_range: float = 400.0 # range of the enemy in which it starts to steer away from other enemies

var current_pos: Vector2 # current position of the pigeon
var player_pos: Vector2

var randX: float = randf_range(-_attack_range, _attack_range) # variable to randomize pigeon movement a little bit
var randZ: float = randf_range(-_attack_range, _attack_range) # variable to randomize pigeon movement a little bit

var pigeons: Array # array of all pigeons currently alive
var local_pigeons: Array # array of all pigeons within the cohesion range

var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()
	pigeons = get_tree().get_nodes_in_group("pigeons")
	player = get_tree().get_nodes_in_group("player")[0]
	current_pos = global_transform.origin
	update_local_pigeons()
	
	
	print(local_pigeons)


func _physics_process(delta: float) -> void:
	var new_velocity: Vector2
	
	update_local_pigeons()
	player_pos = player.global_transform.origin
	current_pos = global_transform.origin
	
	if (player_pos - current_pos).length() < _attack_range:
		new_velocity = (player_pos - current_pos).normalized()
	else:
		new_velocity = (player_pos - current_pos + seperation() + alignment() + cohesion()).normalized()
	
		
	velocity = new_velocity * _speed * delta
	#print(velocity)
	move_and_slide()


func update_local_pigeons() -> void: # updates the local_pigeons array to keep track of our local neighbourhood
	for pigeon in pigeons:
		# if the pigeon at the current position of the array is within the cohesion range,
		# it is not this pigeon and it is not yet within the local neighbourhood, it is added to the local neighbourhood
	 	if current_pos.distance_to(pigeon.global_transform.origin) <= _cohesion_range and pigeon != get_owner() and pigeon not in local_pigeons:
			local_pigeons.append(pigeon)
			
		# if an enemy is not within the cohesion range, but still in our local neighbourhood, it is removed from the local neighbourhood
		if current_pos.distance_to(pigeon.global_transform.origin) > _cohesion_range and pigeon in local_pigeons:
			local_pigeons.erase(pigeon)


#Pigeons want to stay together
func cohesion() -> Vector2:
	var cohesion_velocity: Vector2
	
	#Sum up vector to all pigeons in the neighborhood and average it
	
	if local_pigeons.size() > 0:

		for pigeon in local_pigeons:
			cohesion_velocity += pigeon.global_transform.origin - current_pos
			
			
		cohesion_velocity /= local_pigeons.size()

	return cohesion_velocity


#Pigeons don't want to be too close to each other
func seperation() -> Vector2:
	var seperation_velocity: Vector2
	var distance_to_other: float
	
	#Determine distance to each pigeon in the neighborhood
	#Determine Vector from pigeon in neighborhood to current pigeon (because we want to move away) and divide by the distance so that pigeons that are farther away have less impact
	#Take the average to get the final vector
	if local_pigeons.size() > 0:

		for pigeon in local_pigeons:
			distance_to_other = current_pos.distance_to(pigeon.global_transform.origin)
			if distance_to_other <= _seperation_range:
				seperation_velocity += (current_pos - pigeon.global_transform.origin) / distance_to_other
				
				
	seperation_velocity /= local_pigeons.size()

	return seperation_velocity
		
		
#Pigeons want to fly in the same direction
func alignment() -> Vector2:
	var alignment_velocity: Vector2
	
	#sum up all the headings of pigeons in the neigborhood and average them
	if local_pigeons.size() > 0:
		for pigeon in local_pigeons:
			alignment_velocity += pigeon.velocity
	
	alignment_velocity /= local_pigeons.size()
	
	return alignment_velocity


	

	
	
