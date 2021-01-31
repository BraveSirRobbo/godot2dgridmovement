extends Node2D
export var player = "res://Scenes/Characters/Player.tscn"

func instantiate_player():
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
	player_spawn.position = spawn_points[index].position
	# Make the player face the direction from last movement to create a
	# "seamless" feel
	if GameData.zone_load_facing_direction:
		player_spawn.update_facing(GameData.zone_load_facing_direction)
	
	return player_spawn

func spawnPlayers():
	print("attempting game load")
#	spawn_player(get_tree().get_network_unique_id())
	spawn_player(0)

func spawn_player(id):
	var player = instantiate_player()
	player.name = str(id)
	player.set_network_master(id)
