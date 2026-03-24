extends CharacterBody2D

var SPEED = 500

func _physics_process(delta) -> void:
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1
	else:
		velocity.y = 0
		
	velocity.y *= SPEED
	velocity.x = 0
	move_and_slide()
