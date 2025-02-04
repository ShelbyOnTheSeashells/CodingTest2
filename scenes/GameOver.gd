extends CanvasLayer
@export var player : Node2D

func gameOver():
	get_tree().paused = true
	$TextureRect/Score.text = "SCORE: " + str(player.score)
	$TextureRect/HighScore.text = "HIGHSCORE: " + str(DataManager.data["HighScore"])
	$AnimationPlayer.play("gameOver")
	if DataManager.data["HighScore"] < player.score:
		DataManager.data["HighScore"] = player.score
		DataManager.saveData()
		await $AnimationPlayer.animation_finished
		$TextureRect/HighScore.hide()
		await get_tree().create_timer(.2).timeout
		$TextureRect/HighScore.show()
		await get_tree().create_timer(.2).timeout
		$TextureRect/HighScore.hide()
		$TextureRect/HighScore.text = "HIGHSCORE: " + str(player.score)
		await get_tree().create_timer(.2).timeout
		$TextureRect/HighScore.show()
		


func _on_restart_button_down():
	$"../Transition".transitionTo(null, "restart")


func _on_return_button_down():
	$"../Transition".transitionTo("res://scenes/mainMenu.tscn", null)
