class_name HitBox
extends Area2D

@export var health_handler : healthhandler = null

signal apply_hit(damage : int)

func _ready():
	apply_hit.connect(on_apply_hit)

func on_apply_hit(damage : int) -> void:
	if health_handler == null:
		print("ERROR: HEALT HANDLER NOT ASSIGNED")
		return
	health_handler.apply_damage.emit(damage)
