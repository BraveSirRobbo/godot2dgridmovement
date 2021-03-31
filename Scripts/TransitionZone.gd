extends "res://Scripts/OverworldObject.gd"

export var target_scene = ""
export var target_spawn_point = ""

func do_what_this_object_does():
	
	#if GameData.splodges_squished >= 2:
	print("Trying to transition to ", target_scene, " at spawn point ", target_spawn_point)
	GameData.zone_load_facing_direction = InputSystem.input_direction
	GameData.zone_load_spawn_point = target_spawn_point
	UI.fade_transition_scene(target_scene)
