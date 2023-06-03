extends Control

var lobby = preload("res://Demo/Lobby.tscn").instantiate()


func _on_Host_pressed():
	get_tree().get_root().add_child(lobby)
	get_tree().get_root().get_node("JoinMenu").queue_free()
	NETWORK.create_server()

func _on_Join_pressed():
	get_tree().get_root().add_child(lobby)
	get_tree().get_root().get_node("JoinMenu").queue_free()
	NETWORK.join_server()
