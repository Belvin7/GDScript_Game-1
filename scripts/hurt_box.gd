class_name HurtBox extends Area2D

@export var damage : float = 10.0
#var temp_damage : int = 1

func _ready():
	area_entered.connect(on_area_entered)

func on_area_entered(area: Area2D) -> void:
	if area is HitBox:
		area.apply_hit.emit(damage)
		
		get_parent().queue_free()
