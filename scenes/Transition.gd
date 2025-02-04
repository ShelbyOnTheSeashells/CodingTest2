extends CanvasLayer

@export var pauseMenu : CanvasLayer
var transitioning = false

func transitionOut():
	$AnimationPlayer.play("fadeOut")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false
	if pauseMenu != null: 
		pauseMenu.canPause = true

func transitionTo(newScene, function):
	if !transitioning:
		transitioning = true
		$AnimationPlayer.play("fadeIn")
		await $AnimationPlayer.animation_finished
		if newScene != null:
			get_tree().change_scene_to_file(newScene)
		else:
			match function:
				"quit":
					get_tree().quit()
				"restart":
					get_tree().reload_current_scene()
