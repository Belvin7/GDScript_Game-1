extends Control

func _ready():
	AudioPlayer.play_music_level()

func _on_play_pressed() -> void:
	AudioPlayer.stop()
	get_tree().change_scene_to_file("res://scnes/game.tscn");


func _on_credits_pressed() -> void:
	AudioPlayer.stop()
	get_tree().change_scene_to_file("res://scnes/credits.tscn");


func _on_quit_button_up() -> void:
	get_tree().quit();
