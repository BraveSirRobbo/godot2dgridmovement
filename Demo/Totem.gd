extends "res://Scripts/OverworldObject.gd"

func spawn():
	$Sprite.frame = 8
	print("Raaawr")

func despawn():
	$Sprite.frame = 10
	print("Aaaw")
