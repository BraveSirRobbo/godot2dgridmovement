extends "res://Scripts/Actor.gd"

func _ready():
	if is_multiplayer_authority():
		$Pivot/PlayerCamera.make_current()

func _process(delta):
	if is_multiplayer_authority():
		if InputSystem.input_activation:
			rpc("activate_object")
		elif InputSystem.input_direction:
			rpc("target_position", InputSystem.input_direction)


# Make a vector of the direction we're facing, then ask the grid to interact
# with whatever is there
@rpc("any_peer", "call_local") func activate_object():
	var direction_of_interaction = Vector2((int(dir == DIR.RIGHT) - int(
			dir == DIR.LEFT)), (int(dir == DIR.DOWN) - int(dir == DIR.UP)))
	overworld.request_interaction(self, direction_of_interaction)
