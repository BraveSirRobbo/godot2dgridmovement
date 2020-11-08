extends "res://Scripts/Actor.gd"


func interact(from_direction):
	if GameData.object_picked_up:
		target_position(from_direction)
	else:
		print("You lack that power")
