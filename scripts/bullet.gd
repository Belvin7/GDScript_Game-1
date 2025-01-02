extends CharacterBody2D

@export var bullet_velocity = Vector2(1,0)
@export var bullet_speed = 30
@export var bullet_damage = 10

func _ready() -> void:
	Global.set_bullet_damage(bullet_damage)
	Global.set_bullet_speed(bullet_speed)
	Global.set_bullet_velocity(bullet_velocity)


func _physics_process(delta: float):
	var collision_info = move_and_collide(bullet_velocity.normalized() * delta * bullet_speed)
	
