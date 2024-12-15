class_name HitboxHandler
extends Node

#variablen in den Inspektor exportieren
@export var parent: Node2D = null

signal handle_hitbox
signal update_flock

func _ready():
	handle_hitbox.connect(on_handle_hitbox)
	
func on_handle_hitbox() -> void:
	#parent.emit_signal("update_flock", self.get_parent())
	if get_parent().name == "Player":
		get_tree().paused = true;
		get_tree().change_scene_to_file("res://scnes/winning.tscn")
	 
	parent.queue_free()
	
