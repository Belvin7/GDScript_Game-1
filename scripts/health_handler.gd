class_name healthhandler
extends Node

@export var base_health_max : int = 100
@export var hitbox_handler : HitboxHandler = null
 
var current_healt : int = 0

signal apply_damage(value : int)

func _ready():
	apply_damage.connect(on_apply_damage)
	current_healt = base_health_max

func handle_health() -> void:
	if hitbox_handler == null:
			print('ERROR: HITBOX HANDLER NOT ASSIGNED')
			pass
	
	if current_healt <= 0:
		current_healt=0
		hitbox_handler.handle_hitbox.emit()
	return

func calculate_damage(value:int)-> void:
	current_healt -= value
	print( get_parent().name+ " Healt: " + str(current_healt))


func on_apply_damage(damage : int) -> void:
	calculate_damage(damage)
	handle_health()
