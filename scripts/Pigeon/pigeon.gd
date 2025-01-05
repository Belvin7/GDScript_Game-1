class_name Pigeon
extends CharacterBody2D

@export var _attack_range: float = 200.0 # range of the pigeon in which it starts attacking directly
@export var _cohesion_range: float = 800.0 # range of the pigeon in which it flocks to other pigeons
@export var _seperation_range: float = 400.0 # range of the pigeon in which it starts to steer away from other pigeons

@export var _speed: float = 1000.0 # speed of the pigeon
@export var _damage: float = 10.0 #damage of the pigeon
@export var _health: float = 10.0 #health of the pigeon

var current_pos: Vector2 # current position of the pigeon
var player_pos: Vector2

var randX: float = randf_range(-_attack_range, _attack_range) # variable to randomize pigeon movement a little bit
var randZ: float = randf_range(-_attack_range, _attack_range) # variable to randomize pigeon movement a little bit

var pigeons: Array # array of all pigeons currently alive
var local_pigeons: Array # array of all pigeons within the cohesion range

var player

var upgrades: Array[BasePigeonUpgrade]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# base pigeon setup
	Global.set_pigeon_damage(_damage)
	Global.set_pigeon_speed(_speed)
	Global.set_pigeon_health(_health)
	
	#Upgrades
	upgrades = Global.pigeon_upgrades
	ApplyUpgrades()
	
	#test
	#if Global.get_pigeon_speed() < _speed:
	#	Global.set_pigeon_speed(_speed)
	
	
	#$AudioStreamPlayer.play()
	pigeons = get_tree().get_nodes_in_group("pigeons")
	player = get_tree().get_nodes_in_group("player")[0]
	current_pos = global_transform.origin
	update_local_pigeons()
	upgrades = Global.pigeon_upgrades
	print(upgrades)
	
	
	for upgrade in upgrades:
		upgrade.apply_upgrade(self)
		
	
func _physics_process(delta: float) -> void:
	var new_velocity: Vector2
	
	update_local_pigeons()
	if player != null:
		player_pos = player.global_transform.origin
		current_pos = global_transform.origin
		
		if (player_pos - current_pos).length() < _attack_range:
			new_velocity = (player_pos - current_pos).normalized()
		else:
			new_velocity = (player_pos - current_pos + seperation() + alignment() + cohesion()).normalized()
	
		
	velocity = new_velocity * _speed * delta
	#print(velocity)
	move_and_slide()


# updates the local_pigeons array to keep track of our local neighbourhood
func update_local_pigeons() -> void: 
	if not pigeons.is_empty():
		for pigeon in pigeons:
			
			if pigeon == null:
				local_pigeons.erase(pigeon)
				continue
			# if an enemy is not within the cohesion range, but still in our local neighbourhood, it is removed from the local neighbourhood
			if current_pos.distance_to(pigeon.global_transform.origin) > _cohesion_range and pigeon in local_pigeons:
				local_pigeons.erase(pigeon)
				
			# if the pigeon at the current position of the array is within the cohesion range,
			# it is not this pigeon and it is not yet within the local neighbourhood, it is added to the local neighbourhood
			if current_pos.distance_to(pigeon.global_transform.origin) <= _cohesion_range and pigeon != get_owner() and pigeon not in local_pigeons:
				local_pigeons.append(pigeon)


#Pigeons want to stay together
func cohesion() -> Vector2:
	var cohesion_velocity: Vector2 = Vector2(0, 0)
	
	#Sum up vector to all pigeons in the neighborhood and average it
	
	if local_pigeons.size() > 0:

		for pigeon in local_pigeons:
			cohesion_velocity += pigeon.global_transform.origin - current_pos
			
			
		cohesion_velocity /= local_pigeons.size()

	return cohesion_velocity


#Pigeons don't want to be too close to each other
func seperation() -> Vector2:
	var seperation_velocity: Vector2 = Vector2(0, 0)
	var distance_to_other: float = 0.0
	
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
	var alignment_velocity: Vector2 = Vector2(0, 0)
	
	#sum up all the headings of pigeons in the neigborhood and average them
	if local_pigeons.size() > 0:
		for pigeon in local_pigeons:
			alignment_velocity += pigeon.velocity
	
	alignment_velocity /= local_pigeons.size()
	
	return alignment_velocity
	

#func _on_hitbox_handler_update_flock(pigeon) -> void:
	#if local_pigeons.has(pigeon):
		#local_pigeons.erase(pigeon)

func ApplyUpgrades() -> void:
	if upgrades.size() > 0:
		for item in upgrades:
			item.apply_upgrade(self)
