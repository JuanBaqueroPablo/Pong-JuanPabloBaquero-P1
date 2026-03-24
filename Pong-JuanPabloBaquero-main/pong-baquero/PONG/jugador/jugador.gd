
extends CharacterBody2D

var SPEED = 500

func _physics_process(delta):
	if Input.is_key_pressed(KEY_W):
		velocity.y = -1
	elif Input.is_key_pressed(KEY_S):
		velocity.y = 1
	else:
		velocity.y = 0
		
	velocity.y *= SPEED
	velocity.x = 0
	move_and_slide()
