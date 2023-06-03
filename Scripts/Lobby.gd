extends Control

var map = preload("res://Demo/Main.tscn").instantiate()

func _ready():
	NETWORK.connect("playerNumberChanged", Callable(self, "updatePlayerCount"))

func _on_Start_pressed():
	print("start pressed")
	rpc("buildWorld")

@rpc("any_peer", "call_local") func buildWorld():
	get_tree().get_root().add_child(map)
	get_tree().get_root().get_node("Lobby").queue_free()
	get_tree().get_root().get_node("LevelBase").spawn_player() #emit signals here ?

func updatePlayerCount():
	var noPlayers = NETWORK.players.size()
	$Menu/Butts.text = "Number of Players: " + str(noPlayers)
