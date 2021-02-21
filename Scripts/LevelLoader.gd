extends Node2D
export var player = "res://Scenes/Characters/Player.tscn"

func instantiate_player(id):
	# This sets the player to appear at the correct area when loading into a new
	# zone
	var spawn_points = $"Non-InteractiveTerrain".get_children()
	var index = GameData.zone_load_spawn_point

	# If we somehow don't have that spawn point, fall back to 0
	if len(spawn_points) <= index:
		index = 0


	# Spawn the player and add to scene
	var player_spawn = load(player).instance()
	$InteractiveTerrain.add_child(player_spawn)

	# Set player at the correct position (spawn point of zone)
	var load_offset
	if id > 1:
		load_offset = Vector2(0, 16)
	else:
		load_offset = Vector2(0, 0)
	player_spawn.position = spawn_points[index].position + load_offset
	
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
