extends Node2D


func _ready():
	MusicPlayer.play_music_menu()
	$AnimationPlayer.play("fade in")
	await get_tree().create_timer(8).timeout
	$AnimationPlayer.play("fade out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scnes/main_menu.tscn")
