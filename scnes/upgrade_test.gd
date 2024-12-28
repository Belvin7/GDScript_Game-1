extends Control

@export var pigeon_upgrade : BasePigeonUpgrade


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_upgrade_test_button_up() -> void:
	GlobalPigeonUpgrades.upgrades.append(pigeon_upgrade)
	print(GlobalPigeonUpgrades.upgrades) 


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scnes/game.tscn");
