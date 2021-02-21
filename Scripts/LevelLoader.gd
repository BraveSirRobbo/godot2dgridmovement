extends Node2D
export var player = "res://Scenes/Characters/Player.tscn"

func instantiate_player(id):
	# This sets the player to appear at the correct area when loading into a new
	# zone
	var spawn_name = GameData.zone_load_spawn_point
	var spawn_points = $"Non-InteractiveTerrain".get_node(spawn_name).get_children()

	# Spawn the player and add to scene
	var player_spawn = load(player).instance()
	$InteractiveTerrain.add_child(player_spawn)

	# Set player at the correct position (spawn point of zone)
	var player_offset = int(id > 1)
	player_spawn.position = spawn_points[player_offset].position
	
	# Make the player face the direction from last movement to create a
	# "seamless" feel
	if GameData.zone_load_facing_direction:
		player_spawn.update_facing(GameData.zone_load_facing_direction)
	
	return player_spawn

func spawn_players():
	# Spawn your own player, broadcasting to other cliemnts
	print("attempting game load")
	rpc("spawn_player", get_tree().get_network_unique_id())

remotesync func spawn_player(id):
	# Spawn a player by ID and give it an owner
	var player = instantiate_player(id)
	player.name = str(id)
	player.set_network_master(id)
