extends CharacterBody2D

const debug: bool = false;

const JUMP_VELOCITY = -300.0


@export var SPEED = 130.0
@export var  rotate_speed = 3
@export var  accuracy = 0.1

var enemyList = []


func _physics_process(delta: float) -> void:
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal := Input.get_axis("left", "right")
	var vertical := Input.get_axis("up", "down")
	
	if horizontal:
		velocity.x = horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if vertical:
		velocity.y = vertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	#shooting
	update_Enemy_list()
	#Shot enemy in enemyList
	var tmp = enemyList.size()  # size() aufrufen, um die Anzahl der Elemente zu erhalten
	if enemyList.size() > 0:  # size() aufrufen, um die Bedingung zu überprüfen
		var direction = (enemyList[0].global_position - global_position)
		var angleTo = $Gun.transform.x.angle_to(direction)
		if debug: print("angle:"  + str(abs(angleTo)))
		if abs(angleTo) > 0.01:
			# Rotieren der Waffe in Richtung des Gegners
			$Gun.rotate(sign(angleTo) * min(delta * rotate_speed, abs(angleTo)))
			# Überprüfen, ob die Waffe auf den Gegner zeigt (Winkel fast 0)
			if abs(angleTo) < accuracy:  # Toleranzwert für den Winkel
				$Gun.shotEnemy(enemyList[0])  # Schießen
				
				# Aktuell nur 1 Schuss pro Taube !
				enemyList.remove_at(0)

func _on_view_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if debug: print("Area Entered: " + area.get_parent().name)
	
	#Add Enemy to List
	enemyList.append(enemy)
	
	
	#$Gun.aimAuto(area.get_parent())
	#$Gun.aimAuto(area.get_parent())
	#$Gun.shoot()

func update_Enemy_list() -> void: # updates the local_pigeons array to keep track of our local neighbourhood
	if not enemyList.is_empty():
		for enemy in enemyList:
			if enemy == null:
				enemyList.erase(enemy)
				continue
