class_name WinningMenu
extends Control


@onready var shop_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Shop_Button
@onready var main_menu_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Main_Menu_Button
@export var main_menu: PackedScene = preload("res://scnes/main_menu.tscn")
@export var shop: PackedScene = preload("res://scnes/shop.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func _on_main_up() -> void:
	get_tree().paused = false;
	get_tree().change_scene_to_packed(main_menu) 


func _on_shop_up() -> void:
	get_tree().paused = false;
	get_tree().change_scene_to_packed(shop) 
