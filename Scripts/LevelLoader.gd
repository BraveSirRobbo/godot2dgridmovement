extends Node2D
export var player = "res://Scenes/Characters/Player.tscn"

remotesync func instantiate_player(id):
	# This sets the player to appear at the correct area when loading into a new
	# zone
	var spawn_name = GameData.zone_load_spawn_point
	var spawn_points = $"Non-InteractiveTerrain".get_node(spawn_name).get_children()

	# Spawn the player and add to scene
	var player_spawn = load(player).instance()
	player_spawn.name = str(id)
	player_spawn.set_network_master(id)
	$InteractiveTerrain.add_child(player_spawn)

	# Set player at the correct position (spawn point of zone)
	var player_offset = int(id > 1)
	player_spawn.position = spawn_points[player_offset].position
	
	# Make the player face the direction from last movement to create a
	# "seamless" feel
	if GameData.zone_load_facing_direction:
		player_spawn.update_facing(GameData.zone_load_facing_direction)

func spawn_player():
	# Spawn your own player, broadcasting to other cliemnts
	print("attempting to create player actor")
	rpc("instantiate_player", get_tree().get_network_unique_id())
