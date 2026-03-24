extends Node2D

const GOLES_PARA_GANAR = 5
const valor_inicial = "0"

var puntos_izq = 0
var puntos_der = 0
var puede_puntuar = false
var juego_activo = false

func _ready():
	$Pelota.set_physics_process(false)
	$LabelIzq.text = valor_inicial
	$LabelDer.text = valor_inicial
	$LabelMensaje.text = "Toca Enter para arrancar a jugar"
	$LabelMensaje.visible = true
	$Pausa.reiniciar.connect(_on_reiniciar)
	$Pausa.cambiar_modo.connect(_on_cambiar_modo)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE and juego_activo:
			$Pausa.mostrar()
		if event.keycode == KEY_ENTER and not juego_activo:
			iniciar_juego()

func iniciar_juego():
	juego_activo = true
	$LabelMensaje.visible = false
	await get_tree().create_timer(0.5).timeout
	puede_puntuar = true
	$Pelota.set_physics_process(true)
	$Pelota.iniciar_movimiento()

func verificar_ganador():
	if puntos_izq >= GOLES_PARA_GANAR:
		terminar_juego("Jugador Izquierdo")
	elif puntos_der >= GOLES_PARA_GANAR:
		terminar_juego("Jugador Derecho")

func terminar_juego(ganador):
	juego_activo = false
	puede_puntuar = false
	$Pelota.set_physics_process(false)
	$LabelMensaje.text = "¡Ganó el " + ganador + "!"
	$LabelMensaje.visible = true

func _on_reiniciar():
	get_tree().reload_current_scene()

func _on_cambiar_modo(modo):
	match modo:
		"1v1":
			get_tree().change_scene_to_file("res://PONG/Modos/1v1.tscn")
		"facil":
			get_tree().change_scene_to_file("res://PONG/Modos/modo_facil.tscn")
		"dificil":
			get_tree().change_scene_to_file("res://PONG/Modos/modo_dificil.tscn")

func _on_arco_der_body_entered(body):
	if not puede_puntuar:
		return
	puntos_izq += 1
	$LabelIzq.text = str(puntos_izq)
	verificar_ganador()
	if juego_activo:
		$Pelota.reiniciar_pelota()

func _on_arco_izq_body_entered(body):
	if not puede_puntuar:
		return
	puntos_der += 1
	$LabelDer.text = str(puntos_der)
	verificar_ganador()
	if juego_activo:
		$Pelota.reiniciar_pelota()
