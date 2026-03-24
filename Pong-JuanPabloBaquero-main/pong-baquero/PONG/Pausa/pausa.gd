extends CanvasLayer

signal reiniciar
signal cambiar_modo(modo)

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func mostrar():
	visible = true
	get_tree().paused = true

func ocultar():
	visible = false
	get_tree().paused = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		ocultar()

func _on_nivel_facil_pressed():
	ocultar()
	emit_signal("cambiar_modo", "facil")


func _on_nivel_dificl_pressed():
	ocultar()
	emit_signal("cambiar_modo", "dificil")


func _on_v_1_pressed():
	ocultar()
	emit_signal("cambiar_modo", "1v1")


func _on_reinicar_pressed():
	ocultar()
	emit_signal("reiniciar")
