extends CanvasLayer
@export var player : Node2D
@export var camera : Camera2D
@export var canPause = true

func _input(event):
	if event.is_action_pressed("pause"):
		if canPause:
			if !get_tree().paused:
				player.renderState("Idle")
				get_tree().paused = true
				$AnimationPlayer.play("pauseMenuOpen")
				$Panel/VBoxContainer/Continue.grab_focus()
			else:
				get_tree().paused = false
				$AnimationPlayer.play("pauseMenuClose")
				$Panel/VBoxContainer/Continue.release_focus()



func _on_continue_button_down():
	if canPause:
		get_tree().paused = false
		$AnimationPlayer.play("pauseMenuClose")
		$Panel/VBoxContainer/Continue.release_focus()

func _on_return_button_down():
	$"../Transition".transitionTo("res://scenes/mainMenu.tscn", null)


func _on_give_up_button_down():
	$"../Transition".transitionTo(null, "quit")
