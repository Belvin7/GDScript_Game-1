extends Node2D


func _ready():
	AudioPlayer.play_music_level()
	$AnimationPlayer.play("fade in")
	await get_tree().create_timer(6).timeout
	$AnimationPlayer.play("fade out")
	await get_tree().create_timer(6).timeout
	get_tree().change_scene_to_file("res://scnes/main_menu.tscn")
