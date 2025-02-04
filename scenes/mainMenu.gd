extends Node2D

func _ready():
	$Transition.transitionOut()
	DataManager.loadData()
	$CanvasLayer/Score.text = "HIGHSCORE: " + str(DataManager.data["HighScore"])

func _on_start_button_down():
	$Transition.transitionTo("res://scenes/game.tscn", null)


func _on_give_up_button_down():
	$Transition.transitionTo(null, "quit")
