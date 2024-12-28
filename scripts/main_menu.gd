extends Control

@export var game: PackedScene = preload("res://scnes/game.tscn")
@export var credits: PackedScene = preload("res://scnes/credits.tscn")

func _ready() -> void:
	$MarginContainer/AudioStreamPlayer.play()
	
func _on_play_pressed() -> void:
	AudioPlayer.stop()
	get_tree().change_scene_to_packed(game)


func _on_credits_pressed() -> void:
	AudioPlayer.stop()
	get_tree().change_scene_to_packed(credits)


func _on_quit_button_up() -> void:
	get_tree().quit()
