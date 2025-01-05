class_name SpeedPigeonUpgrade
extends BasePigeonUpgrade


func apply_upgrade(pigeon: Pigeon):
	print("upgrade system speed")
	pigeon._speed += 10000
