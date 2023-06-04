extends Node

var lobby = preload("res://Demo/JoinMenu.tscn").instantiate()
var players = []
signal playerNumberChanged

func _ready():
	multiplayer.connect("peer_connected", Callable(self, "_on_network_peer_connected"))
#	multiplayer.connect("network_peer_disconnected", Callable(self, "_on_network_peer_disconnected"))
	multiplayer.connect("server_disconnected", Callable(self, "_on_server_disconnected"))

func create_server():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(4242, 32)
	multiplayer.set_multiplayer_peer(peer)
	players.append(multiplayer.get_unique_id())

func join_server():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1", 4242)
	multiplayer.set_multiplayer_peer(peer)
	print("Joined server")
	# If server found sends the signal "_on_connected_to_server" to load the game

#func _on_network_peer_disconnected(id):
#	get_tree().get_root().find_node(str(id), true, false).queue_free()

func _on_network_peer_connected(id):
	players.append(id)
	print("Player no. " + str(id) + " has joined")
	print("Current players: " + str(players))
	emit_signal("playerNumberChanged")

func _on_server_disconnected():
	get_tree().get_root().add_child(lobby)
	get_tree().get_root().get_node("Map").queue_free()
	multiplayer.set_multiplayer_peer(null)
