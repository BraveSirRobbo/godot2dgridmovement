extends "res://Scripts/OverworldObject.gd"

#export var target_scene = ""
#export var target_spawn_point = 0

func do_what_this_object_does():
	GameData.splodges_squished += 1
	overworld.check_splodges()
