extends Node2D

var speed = 20
var player_pos
var target_pos

@onready var player = get_tree().get_nodes_in_group("player")[0]  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_pos = player.position
	target_pos = (player_pos-position).normalized()
	
	#Debug
	#print(player_pos)
	
	if position.distance_to(player_pos) > 3:
			position += target_pos * speed * delta
	
	
