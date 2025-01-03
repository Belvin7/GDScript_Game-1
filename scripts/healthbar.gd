extends Node2D


const debug: bool = false

signal healthChange(val:int)

var rage_stage_1_reached: bool = false
var rage_stage_2_reached: bool = false

var event_range_1: int
var event_range_2: int 

var _icon_normal = ImageTexture.create_from_image(Image.load_from_file("res://art/UI/healthbar/tfh_hb_icon.png"))
var _icon_rage_1 = ImageTexture.create_from_image(Image.load_from_file("res://art/UI/healthbar/tfh_hb_icon_2.png"))
#var _icon_rage_2 = ImageTexture.create_from_image(Image.load_from_file("res://art/UI/healthbar/"))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ProgressBar.value = Global.get_player_health()
	if debug: print("Init Bar Value: " + str($ProgressBar.value))
	if debug: print("got from global: " + str(Global.get_player_health()))
	
	# load icon
	$HbIcon.texture = _icon_normal
	
	# set ranges from globals
	event_range_1 = Global.get_event_range_1()
	event_range_2 = Global.get_event_range_2()

func _process(delta: float) -> void:
	$ProgressBar.value = Global.get_player_health()
	if debug: print("progbar val: " + str($ProgressBar.value))
	if $ProgressBar.value <= event_range_1:
		if not rage_stage_1_reached:
			$HbIcon.texture = _icon_rage_1
			healthChange.emit($ProgressBar.value)
			rage_stage_1_reached = true
		
	if $ProgressBar.value <= event_range_2:
		if not rage_stage_2_reached:
			# todo: add icon
			$HbIcon.texture = _icon_rage_1
			healthChange.emit($ProgressBar.value)
			rage_stage_2_reached = true
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	$ProgressBar.value = Global.get_player_health_current()
#	if debug: print("Bar Value: " + str($ProgressBar.value))

#func setHealthbarValue(value):
#	$ProgressBar.value = value
#	if debug: print("set Hb-val: " + str($ProgressBar.value))
	
#func decreaseHealthbarValue(value):
#	$ProgressBar.value -= value
#	if debug: print("dec Hb-val: " + str($ProgressBar.value))

#func increaseHealthbarValue(value):
#	$ProgressBar.value += value
#	if debug: print("inc Hb-val: " + str($ProgressBar.value))
