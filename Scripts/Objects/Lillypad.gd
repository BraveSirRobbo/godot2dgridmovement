extends "res://Scripts/Objects/OverworldObject.gd"

func do_what_this_object_does():
	print("Unlocking super secret house plants")
	GameData.object_picked_up = true
	overworld.gtfo(self)
	queue_free()


func spawn_condition():
	return GameData.object_picked_up == false
