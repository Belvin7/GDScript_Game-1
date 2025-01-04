extends CharacterBody2D

const debug: bool = false;

const JUMP_VELOCITY = -300.0

var invalid_objects := []

@export var player_speed = 130.0
@export var player_rotate_speed = 1
@export var player_accuracy = 0.1
@export var player_health = 100

func _ready() -> void:
	Global.set_player_health(player_health)
	Global.set_player_speed(player_speed)
	Global.set_player_rotate_speed(player_rotate_speed)
	Global.set_player_accuracy(player_accuracy)


var enemyList = []


func _physics_process(delta: float) -> void:
	var horizontal := Input.get_axis("left", "right")
	var vertical := Input.get_axis("up", "down")
	
	if horizontal:
		velocity.x = horizontal * player_speed
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		
	if vertical:
		velocity.y = vertical * player_speed
	else:
		velocity.y = move_toward(velocity.y, 0, player_speed)

	move_and_slide()
	
	#shooting
	
	#ressourcenlastig
	update_Enemy_list()
	#Shot enemy in enemyList
	var lsize = enemyList.size()
	if lsize> 0:
		#Todo fix bug that enemyList[0] is <null>
		var direction = (enemyList[0].global_position - global_position)
		var angleTo = $Gun.transform.x.angle_to(direction)
		if debug: print("angle:"  + str(abs(angleTo)))
		if abs(angleTo) > 0.01:
			# Rotieren der Waffe in Richtung des Gegners
			$Gun.rotate(sign(angleTo) * min(delta * player_rotate_speed, abs(angleTo)))
			# prüfen, ob Waffe auf Gegner zeigt (hier accuracy beachten)
			if abs(angleTo) < player_accuracy: 
				$Gun.shotEnemy(enemyList[0])  # Schießen
				
				# Aktuell nur 1 Schuss pro Taube !
				enemyList.remove_at(0)

func _on_view_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if debug: print("Area Entered: " + area.get_parent().name)
	#Add Enemy to List
	enemyList.append(enemy)


func update_Enemy_list() -> void: #prüfen ob noch alle tauben vorhanden sind
	for id in enemyList:
		if not is_instance_valid(id):
			invalid_objects.append(id)

	for id in invalid_objects:
		enemyList.erase(id)
