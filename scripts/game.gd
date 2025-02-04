extends Node2D
var packages = [0, 1, 2, 3]
#UI
@export var scoreLabel : Label
@export var timerLabel : Label
@export var gameOver : CanvasLayer

@export var timer : Timer
@export var ambience : AudioStreamPlayer2D
var time_left = 60

func _ready():
	get_tree().paused = true
	$Transition.transitionOut()
	

func randomizePackage():
	if packages.size() != 0:
		var random = randi() % packages.size()
		return random

func updateScore(value : int):
	scoreLabel.text = "SCORE: " + str(value)


func _on_timer_timeout():
	if time_left > 0:
		time_left -= 1
		timerLabel.text = str(time_left) + "s"
	else:
		timer.stop()
		gameOver.gameOver()


func _on_ambience_finished():
	ambience.play()
