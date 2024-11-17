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
	if current_healt > 0:
		return
	if current_healt <= 0:
		current_healt=0
		
		if hitbox_handler == null:
			print('ERROR: HITBOX HANDLER NOT ASSIGNED')
			return
		
		hitbox_handler.handle_hitbox.emit()

func calculate_damage(value:int)-> void:
	current_healt -= value
	print("Current Healt: " + str(current_healt))


func on_apply_damage(value : int) -> void:
	handle_health()
	
	if value > 0:
		calculate_damage(value)
