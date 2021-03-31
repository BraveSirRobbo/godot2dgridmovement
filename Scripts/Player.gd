extends "res://Scripts/Actor.gd"

enum Effectors {RIGHT, LEFT, UP, DOWN}

var inputs = {
	"ui_right": Effectors.RIGHT,
	"ui_left": Effectors.LEFT,
	"ui_up": Effectors.UP,
	"ui_down": Effectors.DOWN,
	}

func _ready():
	if is_network_master():
		$Pivot/PlayerCamera.make_current()

func _process(delta):
	if is_network_master():
		if get_input_activation():
			rpc("activate_object")
		elif get_input_direction():
			rpc("target_position", get_input_direction())

func get_input_direction():
	var horizontal = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var vertical = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return Vector2(horizontal, vertical if horizontal == 0 else 0)

func get_input_activation():
	return Input.is_action_just_pressed("ui_accept")





# Make a vector of the direction we're facing, then ask the grid to interact
# with whatever is there
remotesync func activate_object():
	var direction_of_interaction = Vector2((int(dir == DIR.RIGHT) - int(
			dir == DIR.LEFT)), (int(dir == DIR.DOWN) - int(dir == DIR.UP)))
	overworld.request_interaction(self, direction_of_interaction)
