extends Control

var debug : bool = false;

@export var main_menu: PackedScene = preload("res://scnes/main_menu.tscn")
@export var game: PackedScene = preload("res://scnes/game.tscn")

# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	get_node("MarginContainer/VBoxContainer/HBoxContainer/Label").text = str(Global.currency)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_speed_upgrade_button_pressed() -> void:
	if Global.currency >= 10:
		Global.pigeon_upgrades.append(SpeedPigeonUpgrade.new())
		if debug: print ("Upgrade Array Size:" + str(Global.pigeon_upgrades.size()))
		Global.currency -= 10
		get_node("MarginContainer/VBoxContainer/HBoxContainer/Label").text = str(Global.currency)
		print("Upgraded Speed")
	else:
		print("Not enough currency for speed upgrade!") #Placeholder print, should be a pop-up text/toast on screen.


func _on_damage_upgrade_button_pressed() -> void:
	if Global.currency >= 10:
		Global.pigeon_upgrades.append(DamagePigeonUpgrade.new())
		Global.currency -= 10
		get_node("MarginContainer/VBoxContainer/HBoxContainer/Label").text = str(Global.currency)
		print("Upgraded Damage")
	else:
		print("Not enough currency for damage upgrade!") #Placeholder print, should be a pop-up text/toast on screen.

func _on_health_upgrade_button_pressed() -> void:
	if Global.currency >= 10:
		Global.pigeon_upgrades.append(HealthPigeonUpgrade.new())
		Global.currency -= 10
		get_node("MarginContainer/VBoxContainer/HBoxContainer/Label").text = str(Global.currency)
		print("Upgraded Health")
	else:
		print("Not enough currency for health upgrade!") #Placeholder print, should be a pop-up text/toast on screen.


func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_packed(game)


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)
