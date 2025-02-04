extends CharacterBody2D

@export var sfx : AudioStreamPlayer2D
@export var game : Node2D
@export var camera : Camera2D

@export var uiAnimation : AnimationPlayer
@export var animationPlayer : AnimationPlayer
@export var objectivePanel : Panel
@export var objective : Label

var movement
var interactableObject : Node2D

var held = null
var score = 0

@export var speed = 500

func _input(event):
	if event.is_action_pressed("interact"):
		if interactableObject != null:
			if interactableObject.is_in_group("Truck"):
				if held == null:
					held = game.randomizePackage()
					soundeffect("res://assets/sounds/package handled.ogg")
					objective.text = "SHIP TO DOOR " + str(held + 1)
					uiAnimation.play("objective")
			elif interactableObject.is_in_group("Recipient"):
				if held != null:
					soundeffect("res://assets/sounds/door close.ogg")
					objectivePanel.hide()
					if interactableObject.id == held:
						score += 500
					else:
						score -= 300
						if score < 0:
							score = 0
	
					game.updateScore(score)
						
					held = null
		
		

func soundeffect(audio):
	if sfx.playing:
		sfx.stop()
	sfx.stream = load(audio)
	sfx.play()

func _physics_process(delta):
	movement = Input.get_axis("left", "right")
	velocity.x = movement * speed
	move_and_slide()
	
	if movement != 0:
		renderState("Run")
		animationPlayer.play("Move")
		if movement > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
	else:
		renderState("Idle")
		animationPlayer.stop()
	
	camera.global_position = camera.global_position.move_toward(Vector2(position.x, position.y - 200), 10)


func renderState(state):
	if held != null:
		$Sprite2D.texture = load("res://assets/art/player/playerHold" + state + ".png")
	else:
		$Sprite2D.texture = load("res://assets/art/player/player" + state + ".png")

func _on_area_2d_body_entered(body):
	interactableObject = body
	


func _on_area_2d_body_exited(body):
	if body == interactableObject:
		interactableObject = null

