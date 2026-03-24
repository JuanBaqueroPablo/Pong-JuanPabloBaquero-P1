extends CharacterBody2D
var SPEED = 350
@export var pelota: Node2D

func _physics_process(delta) -> void:
	if pelota.global_position.y < global_position.y:
		velocity.y = -1
	elif pelota.global_position.y > global_position.y:
		velocity.y = 1
	else:
		velocity.y = 0
	velocity.y *= SPEED
	velocity.x = 0
	move_and_slide()
