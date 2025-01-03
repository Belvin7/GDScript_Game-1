extends Node

var pigeon_upgrades: Array[BasePigeonUpgrade] = []

var currency: int = 0 

################
#Global Vars
################

#pigeons
var pigeon_max_counter: int
var pigeon_current_counter: int
var pigeon_speed: int
var pigeon_damage: int
var pigeon_healt:int

#player
var player_health:int
var player_speed: int
var player_rotate_speed: int
var player_accuracy: int

#bullet
var bullet_velocity: Vector2
var bullet_speed: int
var bullet_damage: int

#ranges for health based changes
var event_range_1: int = 50
var event_range_2: int = 25

################
# Get / Set Functions
################

###
# Getters and Setters for Pigeons
###
func set_pigeon_max_counter(value: int) -> void:
	pigeon_max_counter = value

func get_pigeon_max_counter() -> int:
	return pigeon_max_counter

func set_pigeon_current_counter(value: int) -> void:
	pigeon_current_counter = value

func get_pigeon_current_counter() -> int:
	return pigeon_current_counter

func set_pigeon_speed(value: int) -> void:
	pigeon_speed = value

func get_pigeon_speed() -> int:
	return pigeon_speed
	
func set_pigeon_damage(value: int) -> void:
	pigeon_damage = value

func get_pigeon_damage() -> int:
	return pigeon_damage
	
func set_pigeon_health(value: int) -> void:
	pigeon_healt = value

func get_pigeon_healt() -> int:
	return pigeon_healt

###
# Getters and Setters for Player
###
func set_player_health(value: int) -> void:
	player_health = value

func get_player_health() -> int:
	return player_health

func set_player_speed(value: int) -> void:
	player_speed = value

func get_player_speed() -> int:
	return player_speed

func set_player_rotate_speed(value: int) -> void:
	player_rotate_speed = value

func get_player_rotate_speed() -> int:
	return player_rotate_speed

func set_player_accuracy(value: int) -> void:
	player_accuracy = value

func get_player_accuracy() -> int:
	return player_accuracy

###
# Getters and Setters for Bullet
###
func set_bullet_velocity(value: Vector2) -> void:
	bullet_velocity = value

func get_bullet_velocity() -> Vector2:
	return bullet_velocity

func set_bullet_speed(value: int) -> void:
	bullet_speed = value

func get_bullet_speed() -> int:
	return bullet_speed

func set_bullet_damage(value: int) -> void:
	bullet_damage = value

func get_bullet_damage() -> int:
	return bullet_damage

func get_event_range_1() -> int:
	return event_range_1
	
func get_event_range_2() -> int:
	return event_range_2
