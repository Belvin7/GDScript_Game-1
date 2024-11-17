extends CharacterBody2D

var bullet_velocity = Vector2(1,0)
var bullet_speed = 300
var bullet_damage = 10

func _physics_process(delta: float):
	var collision_info = move_and_collide(bullet_velocity.normalized() * delta * bullet_speed)
	
