extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func fade_transition_scene(scene):
	$FadePanel.visible = true
	animation_player.play("FadeOut")
	InputSystem.disable_input_until(animation_player, "animation_finished")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene)
	animation_player.play("FadeIn")
	InputSystem.disable_input_until(animation_player, "animation_finished")
	await animation_player.animation_finished
	$FadePanel.visible = false
