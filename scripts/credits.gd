extends Control

var speed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$RichTextLabel.position.y -= speed * delta


func _on_button_pressed() -> void:
	$AudioStreamPlayer.stop()
	get_tree().change_scene_to_file("res://scnes/main_menu.tscn") # Replace with function body.
