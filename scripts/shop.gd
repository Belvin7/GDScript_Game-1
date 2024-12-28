extends Control

@export var main_menu: PackedScene = preload("res://scnes/main_menu.tscn")
@export var game: PackedScene = preload("res://scnes/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_speed_upgrade_button_pressed() -> void:
	GlobalPigeonUpgrades.upgrades.append(SpeedPigeonUpgrade)


func _on_damage_upgrade_button_pressed() -> void:
	GlobalPigeonUpgrades.upgrades.append(DamagePigeonUpgrade)


func _on_health_upgrade_button_pressed() -> void:
	GlobalPigeonUpgrades.upgrades.append(HealthPigeonUpgrade)
