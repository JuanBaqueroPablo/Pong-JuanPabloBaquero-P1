extends CharacterBody2D

@export var velocidad_inicial = 400.0
@export var incremento_velocidad = 20.0
@export var velocidad_maxima = 800.0

var velocidad_actual = 0.0
var direccion = Vector2.ZERO

func _ready():
	var center_screen = get_viewport_rect().size / 2
	global_position = center_screen
	iniciar_movimiento()

func _physics_process(delta: float):
	var colision = move_and_collide(direccion * velocidad_actual * delta)
	if colision:
		var normal = colision.get_normal()
		direccion = direccion.bounce(normal)
		velocidad_actual = clamp(velocidad_actual + incremento_velocidad, velocidad_inicial, velocidad_maxima)

func iniciar_movimiento():
	velocidad_actual = velocidad_inicial
	direccion = Vector2([-1, 1].pick_random(), randf_range(-0.8, 0.8)).normalized()

func reiniciar_pelota():
	var center_screen = get_viewport_rect().size / 2
	global_position = center_screen
	set_physics_process(false)
	await get_tree().create_timer(1.0).timeout
	set_physics_process(true)
	iniciar_movimiento()
