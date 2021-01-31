extends Control

func _ready():
	NETWORK.connect("playerNumberChanged", self, "updatePlayerCount")

func _on_Start_pressed():
	return

func updatePlayerCount():
	var noPlayers = NETWORK.players.size()
	$Menu/Butts.text = "Number of Players: " + str(noPlayers)
