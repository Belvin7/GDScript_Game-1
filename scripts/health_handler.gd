class_name healthhandler
extends Node


@export var hitbox_handler : HitboxHandler = null
 
var current_healt : int = 0

signal apply_damage(value : int)

func _ready():
	apply_damage.connect(on_apply_damage)



func handle_health() -> void:
	if hitbox_handler == null:
			print('ERROR: HITBOX HANDLER NOT ASSIGNED')
			pass
	
	if current_healt <= 0:
		current_healt=0
		hitbox_handler.handle_hitbox.emit()
	return

func calculate_damage(value:int)-> void:
	
	if get_parent().name == "Player":
		current_healt = Global.get_player_health()
	
	if get_parent().name == "Pigeon":
		current_healt = Global.get_pigeon_healt() 
	
	current_healt -= value
	print( get_parent().name+ " Healt: " + str(current_healt))
	
	if get_parent().name == "Player":
		Global.set_player_health(current_healt)
	
	if get_parent().name == "Pigeon":
		Global.set_pigeon_health(current_healt)


func on_apply_damage(damage : int) -> void:
	calculate_damage(damage)
	handle_health()
